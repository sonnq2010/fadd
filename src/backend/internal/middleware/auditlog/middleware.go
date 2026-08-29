package auditlog

import (
	"bufio"
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net"
	"net/http"
	"strings"
	"time"

	"github.com/google/uuid"

	"github.com/sonnq2010/fadd/src/backend/internal/apperrors"
	"github.com/zeromicro/go-zero/core/logx"
	"github.com/zeromicro/go-zero/rest/httpx"

	"github.com/sonnq2010/fadd/src/backend/internal/middleware"
)

const (
	requestIDHeader = "X-Request-ID"
	maxLoggedBody   = 64 * 1024
)

type auditLogger interface {
	Infow(string, ...logx.LogField)
	Errorw(string, ...logx.LogField)
}

// RequestAuditMiddleware logs one structured audit event for each matched request.
type RequestAuditMiddleware struct {
	logger auditLogger
}

// NewRequestAuditMiddleware creates the production request audit middleware.
func NewRequestAuditMiddleware() *RequestAuditMiddleware {
	return &RequestAuditMiddleware{}
}

func newRequestAuditMiddleware(logger auditLogger) *RequestAuditMiddleware {
	return &RequestAuditMiddleware{logger: logger}
}

// Handle records request, response, identity, and error metadata.
func (m *RequestAuditMiddleware) Handle(next http.HandlerFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		requestID := r.Header.Get(requestIDHeader)
		if requestID == "" {
			requestID = uuid.NewString()
		}
		w.Header().Set(requestIDHeader, requestID)

		ctx := middleware.WithRequestID(r.Context(), requestID)
		ctx, _ = middleware.WithAuditState(ctx)
		r = r.WithContext(ctx)
		requestBody := captureRequestBody(r)
		started := time.Now()
		writer := newAuditResponseWriter(w)

		next(writer, r)

		event := buildAuditEvent(r, writer, requestBody, time.Since(started))
		fields := event.fields()
		logger := m.logger
		if logger == nil {
			logger = logx.WithContext(r.Context())
		}
		if event.Level == "error" {
			logger.Errorw("request_audit", fields...)
		} else {
			logger.Infow("request_audit", fields...)
		}
	}
}

type auditEvent struct {
	Timestamp         string
	Level             string
	RequestID         string
	Method            string
	Host              string
	Path              string
	Query             string
	RequestBody       string
	Protocol          string
	ClientIP          string
	UserAgent         string
	UserID            string
	Role              string
	StatusCode        int
	LatencyMS         int64
	ResponseSizeBytes int64
	ErrorCode         string
	ErrorMessage      string
}

func (e auditEvent) fields() []logx.LogField {
	return []logx.LogField{
		logx.Field("timestamp", e.Timestamp),
		logx.Field("level", e.Level),
		logx.Field("method", e.Method),
		logx.Field("host", e.Host),
		logx.Field("path", e.Path),
		logx.Field("query", e.Query),
		logx.Field("request_body_redacted", e.RequestBody),
		logx.Field("protocol", e.Protocol),
		logx.Field("client_ip", e.ClientIP),
		logx.Field("user_agent", e.UserAgent),
		logx.Field("user_id", e.UserID),
		logx.Field("role", e.Role),
		logx.Field("status_code", e.StatusCode),
		logx.Field("latency_ms", e.LatencyMS),
		logx.Field("response_size_bytes", e.ResponseSizeBytes),
		logx.Field("error_code", e.ErrorCode),
		logx.Field("error_message", e.ErrorMessage),
	}
}

func buildAuditEvent(r *http.Request, w *auditResponseWriter, requestBody string, latency time.Duration) auditEvent {
	principal, _ := middleware.PrincipalFromContext(r.Context())
	event := auditEvent{
		Timestamp:         time.Now().UTC().Format(time.RFC3339Nano),
		Level:             levelForStatus(w.status),
		RequestID:         middleware.RequestIDFromContext(r.Context()),
		Method:            r.Method,
		Host:              r.Host,
		Path:              r.URL.Path,
		Query:             r.URL.RawQuery,
		RequestBody:       requestBody,
		Protocol:          r.Proto,
		ClientIP:          httpx.GetRemoteAddr(r),
		UserAgent:         r.UserAgent(),
		UserID:            principal.UserID,
		Role:              principal.Role,
		StatusCode:        w.status,
		LatencyMS:         latency.Milliseconds(),
		ResponseSizeBytes: w.size,
	}
	if event.StatusCode >= http.StatusBadRequest {
		event.ErrorCode, event.ErrorMessage = responseError(w.body.Bytes())
		if err := middleware.ErrorFromAuditState(r.Context()); err != nil {
			event.ErrorMessage = apperrors.Cause(err).Error()
		}
	}
	return event
}

func levelForStatus(status int) string {
	switch {
	case status >= http.StatusInternalServerError:
		return "error"
	case status >= http.StatusBadRequest:
		return "warn"
	default:
		return "info"
	}
}

func captureRequestBody(r *http.Request) string {
	if r.Body == nil {
		return ""
	}
	captured, err := io.ReadAll(io.LimitReader(r.Body, maxLoggedBody+1))
	r.Body = io.NopCloser(io.MultiReader(bytes.NewReader(captured), r.Body))
	if err != nil {
		return "[unavailable]"
	}
	if len(captured) > maxLoggedBody {
		return "[redacted: body exceeds logging limit]"
	}
	return redactBody(captured, r.Header.Get("Content-Type"))
}

func redactBody(body []byte, contentType string) string {
	if len(body) == 0 {
		return ""
	}
	var value any
	if strings.Contains(strings.ToLower(contentType), "json") && json.Unmarshal(body, &value) == nil {
		redactValue(value)
		redacted, err := json.Marshal(value)
		if err == nil {
			return string(redacted)
		}
	}
	return fmt.Sprintf("[redacted: non-JSON body, %d bytes]", len(body))
}

func redactValue(value any) {
	switch current := value.(type) {
	case map[string]any:
		for key, nested := range current {
			if isSensitiveKey(key) {
				current[key] = "[REDACTED]"
				continue
			}
			redactValue(nested)
		}
	case []any:
		for _, nested := range current {
			redactValue(nested)
		}
	}
}

func isSensitiveKey(key string) bool {
	key = strings.ToLower(strings.ReplaceAll(strings.ReplaceAll(key, "-", ""), "_", ""))
	for _, sensitive := range []string{"password", "passwd", "token", "secret", "authorization", "cookie", "apikey", "accesstoken", "refreshtoken"} {
		if key == sensitive || strings.HasSuffix(key, sensitive) {
			return true
		}
	}
	return false
}

type responseErrorPayload struct {
	Error struct {
		Code    string `json:"code"`
		Message string `json:"message"`
	} `json:"error"`
}

func responseError(body []byte) (string, string) {
	var payload responseErrorPayload
	if json.Unmarshal(body, &payload) != nil {
		return "", ""
	}
	return payload.Error.Code, payload.Error.Message
}

type auditResponseWriter struct {
	http.ResponseWriter
	status int
	size   int64
	body   bytes.Buffer
}

func newAuditResponseWriter(writer http.ResponseWriter) *auditResponseWriter {
	return &auditResponseWriter{ResponseWriter: writer, status: http.StatusOK}
}

func (w *auditResponseWriter) WriteHeader(status int) {
	if w.status != http.StatusOK {
		return
	}
	w.status = status
	w.ResponseWriter.WriteHeader(status)
}

func (w *auditResponseWriter) Write(body []byte) (int, error) {
	if w.status == http.StatusOK {
		w.WriteHeader(http.StatusOK)
	}
	w.size += int64(len(body))
	if w.body.Len() < maxLoggedBody {
		_, _ = w.body.Write(body[:min(len(body), maxLoggedBody-w.body.Len())])
	}
	return w.ResponseWriter.Write(body)
}

func (w *auditResponseWriter) Flush() {
	w.WriteHeader(w.status)
	if flusher, ok := w.ResponseWriter.(http.Flusher); ok {
		flusher.Flush()
	}
}

func (w *auditResponseWriter) Unwrap() http.ResponseWriter {
	return w.ResponseWriter
}

func (w *auditResponseWriter) Hijack() (net.Conn, *bufio.ReadWriter, error) {
	hijacker, ok := w.ResponseWriter.(http.Hijacker)
	if !ok {
		return nil, nil, fmt.Errorf("response writer does not support hijacking")
	}
	return hijacker.Hijack()
}

func (w *auditResponseWriter) ReadFrom(reader io.Reader) (int64, error) {
	return io.Copy(struct{ io.Writer }{Writer: w}, reader)
}

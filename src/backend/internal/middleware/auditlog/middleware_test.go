package auditlog

import (
	"context"
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/zeromicro/go-zero/core/logx"

	"github.com/sonnq2010/fadd/src/backend/internal/middleware"
)

type capturedAudit struct {
	level  string
	fields map[string]any
}

func (l *capturedAudit) Infow(_ string, fields ...logx.LogField)  { l.capture("info", fields) }
func (l *capturedAudit) Errorw(_ string, fields ...logx.LogField) { l.capture("error", fields) }
func (l *capturedAudit) capture(level string, fields []logx.LogField) {
	l.level = level
	l.fields = make(map[string]any, len(fields))
	for _, field := range fields {
		l.fields[field.Key] = field.Value
	}
}

func TestRequestAuditMiddlewareCapturesRequestAndResponse(t *testing.T) {
	t.Parallel()

	logger := new(capturedAudit)
	requestMiddleware := newRequestAuditMiddleware(logger)
	handler := requestMiddleware.Handle(func(w http.ResponseWriter, r *http.Request) {
		body, err := io.ReadAll(r.Body)
		if err != nil {
			t.Errorf("read request body: %v", err)
		}
		if string(body) != `{"password":"secret","profile":{"token":"abc","name":"Ada"}}` {
			t.Errorf("handler body = %s", body)
		}
		w.WriteHeader(http.StatusCreated)
		_, _ = w.Write([]byte(`{"ok":true}`))
	})

	recorder := httptest.NewRecorder()
	request := httptest.NewRequest(http.MethodPost, "https://api.example.test/users?verbose=true", strings.NewReader(`{"password":"secret","profile":{"token":"abc","name":"Ada"}}`))
	request.Header.Set("Content-Type", "application/json")
	request.Header.Set("User-Agent", "audit-test")
	request.RemoteAddr = "192.0.2.10:1234"
	handler(recorder, request)

	if recorder.Code != http.StatusCreated {
		t.Fatalf("status = %d, want %d", recorder.Code, http.StatusCreated)
	}
	if recorder.Header().Get(requestIDHeader) == "" {
		t.Fatal("request ID response header is empty")
	}
	if middleware.RequestIDFromContext(request.Context()) != "" {
		t.Fatal("original request context was unexpectedly mutated")
	}
	if logger.level != "info" {
		t.Fatalf("logger level = %q, want info", logger.level)
	}
	if got := logger.fields["method"]; got != http.MethodPost {
		t.Errorf("method = %v", got)
	}
	if got := logger.fields["host"]; got != "api.example.test" {
		t.Errorf("host = %v", got)
	}
	if got := logger.fields["path"]; got != "/users" {
		t.Errorf("path = %v", got)
	}
	if got := logger.fields["query"]; got != "verbose=true" {
		t.Errorf("query = %v", got)
	}
	if got := logger.fields["client_ip"]; got != "192.0.2.10:1234" {
		t.Errorf("client_ip = %v", got)
	}
	body := logger.fields["request_body_redacted"].(string)
	if strings.Contains(body, "secret") || strings.Contains(body, "abc") {
		t.Errorf("redacted body contains secret: %s", body)
	}
	if !strings.Contains(body, `"name":"Ada"`) {
		t.Errorf("redacted body lost safe field: %s", body)
	}
	if got := logger.fields["status_code"]; got != http.StatusCreated {
		t.Errorf("status_code = %v", got)
	}
	if got := logger.fields["response_size_bytes"]; got != int64(len(`{"ok":true}`)) {
		t.Errorf("response size = %v", got)
	}
}

func TestRequestAuditMiddlewareUsesRequestIDAndPrincipal(t *testing.T) {
	t.Parallel()

	logger := new(capturedAudit)
	handler := newRequestAuditMiddleware(logger).Handle(func(w http.ResponseWriter, r *http.Request) {
		if middleware.RequestIDFromContext(r.Context()) != "incoming-id" {
			t.Error("request ID missing from context")
		}
		w.WriteHeader(http.StatusUnauthorized)
		_, _ = w.Write([]byte(`{"success":false,"error":{"code":"UNAUTHORIZED","message":"not allowed"}}`))
	})

	request := httptest.NewRequest(http.MethodGet, "/private", nil)
	request.Header.Set(requestIDHeader, "incoming-id")
	request = request.WithContext(middleware.WithPrincipal(context.Background(), middleware.Principal{UserID: "user-1", Role: "admin"}))
	recorder := httptest.NewRecorder()
	handler(recorder, request)

	if recorder.Header().Get(requestIDHeader) != "incoming-id" {
		t.Fatalf("request ID = %q", recorder.Header().Get(requestIDHeader))
	}
	if logger.fields["user_id"] != "user-1" || logger.fields["role"] != "admin" {
		t.Fatalf("principal fields = %v", logger.fields)
	}
	if logger.fields["error_code"] != "UNAUTHORIZED" || logger.fields["error_message"] != "not allowed" {
		t.Fatalf("error fields = %v", logger.fields)
	}
	if logger.fields["level"] != "warn" || logger.level != "info" {
		t.Fatalf("levels = event %v logger %q", logger.fields["level"], logger.level)
	}
}

func TestRedactBodyRejectsNonJSONAndOversizedBody(t *testing.T) {
	t.Parallel()

	if got := redactBody([]byte("password=secret"), "application/x-www-form-urlencoded"); !strings.Contains(got, "non-JSON") {
		t.Fatalf("non-JSON body = %q", got)
	}
	if got := redactBody([]byte(`{"password":"secret"}`), "application/json"); strings.Contains(got, "secret") {
		t.Fatalf("JSON body was not redacted: %q", got)
	}
}

func TestResponseError(t *testing.T) {
	t.Parallel()

	code, message := responseError([]byte(`{"error":{"code":"BAD_REQUEST","message":"invalid input"}}`))
	if code != "BAD_REQUEST" || message != "invalid input" {
		t.Fatalf("error = %q, %q", code, message)
	}
}

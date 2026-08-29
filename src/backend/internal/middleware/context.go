package middleware

import (
	"context"
	"sync"

	"github.com/zeromicro/go-zero/core/logx"
)

type contextKey string

const (
	requestIDKey  contextKey = "request_id"
	principalKey  contextKey = "principal"
	auditStateKey contextKey = "audit_state"
)

// Principal identifies the authenticated caller for request-scoped logging.
type Principal struct {
	UserID string
	Role   string
}

// WithRequestID stores requestID in ctx for downstream handlers and logs.
func WithRequestID(ctx context.Context, requestID string) context.Context {
	ctx = context.WithValue(ctx, requestIDKey, requestID)
	return logx.ContextWithFields(ctx, logx.Field("request_id", requestID))
}

// RequestIDFromContext returns the request ID stored in ctx.
func RequestIDFromContext(ctx context.Context) string {
	requestID, _ := ctx.Value(requestIDKey).(string)
	return requestID
}

// WithPrincipal stores the authenticated principal in ctx.
func WithPrincipal(ctx context.Context, principal Principal) context.Context {
	return context.WithValue(ctx, principalKey, principal)
}

// PrincipalFromContext returns the authenticated principal stored in ctx.
func PrincipalFromContext(ctx context.Context) (Principal, bool) {
	principal, ok := ctx.Value(principalKey).(Principal)
	return principal, ok
}

// AuditState carries the original error produced while handling a request.
type AuditState struct {
	mu  sync.RWMutex
	err error
}

// WithAuditState attaches request-scoped audit state to ctx.
func WithAuditState(ctx context.Context) (context.Context, *AuditState) {
	state := new(AuditState)
	return context.WithValue(ctx, auditStateKey, state), state
}

// AuditStateFromContext returns request-scoped audit state from ctx.
func AuditStateFromContext(ctx context.Context) *AuditState {
	state, _ := ctx.Value(auditStateKey).(*AuditState)
	return state
}

// RecordError stores the original request error for the audit event.
func RecordError(ctx context.Context, err error) {
	state := AuditStateFromContext(ctx)
	if state == nil {
		return
	}
	state.mu.Lock()
	state.err = err
	state.mu.Unlock()
}

// ErrorFromAuditState returns the original request error, if one was recorded.
func ErrorFromAuditState(ctx context.Context) error {
	state := AuditStateFromContext(ctx)
	if state == nil {
		return nil
	}
	state.mu.RLock()
	defer state.mu.RUnlock()
	return state.err
}

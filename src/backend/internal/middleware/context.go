package middleware

import (
	"context"

	"github.com/zeromicro/go-zero/core/logx"
)

type contextKey string

const (
	requestIDKey contextKey = "request_id"
	principalKey contextKey = "principal"
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

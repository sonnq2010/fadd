package auth

import "net/http"

// AuthMiddleware is an insecure pass-through placeholder for authentication.
type AuthMiddleware struct{}

// NewAuthMiddleware creates the authentication placeholder.
func NewAuthMiddleware() *AuthMiddleware {
	return &AuthMiddleware{}
}

// Handle currently delegates every request without authentication.
func (m *AuthMiddleware) Handle(next http.HandlerFunc) http.HandlerFunc {
	// TODO: validate credentials and add authenticated principal to request context.
	return next
}

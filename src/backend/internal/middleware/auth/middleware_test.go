package auth

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestAuthMiddlewarePlaceholderPassesRequestThrough(t *testing.T) {
	t.Parallel()

	called := false
	handler := NewAuthMiddleware().Handle(func(w http.ResponseWriter, _ *http.Request) {
		called = true
		w.WriteHeader(http.StatusNoContent)
	})

	recorder := httptest.NewRecorder()
	handler(recorder, httptest.NewRequest(http.MethodGet, "/", nil))

	if !called {
		t.Fatal("next handler was not called")
	}
	if recorder.Code != http.StatusNoContent {
		t.Fatalf("status = %d, want %d", recorder.Code, http.StatusNoContent)
	}
}

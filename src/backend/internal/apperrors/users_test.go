package apperrors

import (
	"errors"
	"net/http"
	"testing"
)

func TestUserErrors(t *testing.T) {
	t.Parallel()

	cause := errors.New("cause")
	tests := []struct {
		name        string
		create      func(error) *AppError
		wantCode    string
		wantMessage string
		wantStatus  int
	}{
		{
			name:        "invalid user id",
			create:      InvalidUserID,
			wantCode:    CodeInvalidUserID,
			wantMessage: "invalid user id",
			wantStatus:  http.StatusBadRequest,
		},
		{
			name:        "user not found",
			create:      UserNotFound,
			wantCode:    CodeUserNotFound,
			wantMessage: "user not found",
			wantStatus:  http.StatusNotFound,
		},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()

			appErr := test.create(cause)
			if appErr.Code != test.wantCode {
				t.Errorf("code = %q, want %q", appErr.Code, test.wantCode)
			}
			if appErr.Message != test.wantMessage {
				t.Errorf("message = %q, want %q", appErr.Message, test.wantMessage)
			}
			if appErr.StatusCode != test.wantStatus {
				t.Errorf("status = %d, want %d", appErr.StatusCode, test.wantStatus)
			}
			if !errors.Is(appErr, cause) {
				t.Error("application error does not retain cause")
			}
		})
	}
}

package apperrors

import "net/http"

const (
	CodeInvalidUserID = "INVALID_USER_ID"
	CodeUserNotFound  = "USER_NOT_FOUND"
)

// InvalidUserID creates the public error for a malformed user identifier.
func InvalidUserID(err error) *AppError {
	return New(CodeInvalidUserID, "invalid user id", http.StatusBadRequest, err)
}

// UserNotFound creates the public error for a missing user.
func UserNotFound(err error) *AppError {
	return New(CodeUserNotFound, "user not found", http.StatusNotFound, err)
}

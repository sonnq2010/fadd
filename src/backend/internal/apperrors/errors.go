// Package apperrors defines errors shared between business logic and HTTP handlers.
package apperrors

import (
	"errors"
	"fmt"
	"net/http"
)

const CodeInternalError = "INTERNAL_ERROR"

// AppError carries a safe API error while retaining the underlying cause.
type AppError struct {
	Code       string
	Message    string
	StatusCode int
	Err        error
}

// Error returns the safe message exposed by the application error.
func (e *AppError) Error() string { return e.Message }

// Unwrap exposes the underlying cause to errors.Is and errors.As.
func (e *AppError) Unwrap() error { return e.Err }

// New creates an application error with a public code and message.
func New(code, message string, statusCode int, err error) *AppError {
	return &AppError{Code: code, Message: message, StatusCode: statusCode, Err: err}
}

// Internal creates a sanitized internal-server-error response around err.
func Internal(err error) *AppError {
	return New(CodeInternalError, "internal server error", http.StatusInternalServerError, err)
}

// From returns err when it is already an AppError, otherwise sanitizes it.
func From(err error) *AppError {
	var appErr *AppError
	if errors.As(err, &appErr) {
		return appErr
	}
	return Internal(err)
}

// Cause returns the underlying technical cause for restricted diagnostic logs.
func Cause(err error) error {
	var appErr *AppError
	if errors.As(err, &appErr) && appErr.Err != nil {
		return appErr.Err
	}
	return err
}

// WrapInternal preserves context while returning a safe internal error.
func WrapInternal(operation string, err error) *AppError {
	return Internal(fmt.Errorf("%s: %w", operation, err))
}

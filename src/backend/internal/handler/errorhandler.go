package handler

import (
	"context"
	"errors"

	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/rest/httpx"

	"github.com/sonnq2010/fadd/src/backend/internal/apperrors"
	"github.com/sonnq2010/fadd/src/backend/internal/middleware"
	"github.com/sonnq2010/fadd/src/backend/internal/types"
)

// ConfigureErrorHandler installs the application's centralized HTTP error mapper.
func ConfigureErrorHandler() {
	httpx.SetErrorHandlerCtx(HandleError)
}

// HandleError records the original error, logs its cause, and creates a safe response.
func HandleError(ctx context.Context, err error) (int, any) {
	middleware.RecordError(ctx, err)
	logc.Errorw(ctx, "business_error", logc.Field("error", apperrors.Cause(err)))

	appErr := apperrors.From(err)
	return appErr.StatusCode, types.ErrorResp{
		Success: false,
		Error: types.APIError{
			Code:    appErr.Code,
			Message: appErr.Message,
		},
	}
}

// IsApplicationError reports whether err contains an application error.
func IsApplicationError(err error) bool {
	var appErr *apperrors.AppError
	return errors.As(err, &appErr)
}

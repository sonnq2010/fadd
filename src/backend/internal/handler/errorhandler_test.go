package handler

import (
	"context"
	"encoding/json"
	"errors"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/sonnq2010/fadd/src/backend/internal/middleware"
	"github.com/sonnq2010/fadd/src/backend/internal/types"
	"github.com/zeromicro/go-zero/rest/httpx"
)

func TestHandleErrorReturnsSafeResponseAndRecordsOriginalError(t *testing.T) {
	original := errors.New("database: connection refused")
	ctx, state := middleware.WithAuditState(
		middleware.WithRequestID(context.Background(), "request-1"),
	)

	status, body := HandleError(ctx, original)
	if status != http.StatusInternalServerError {
		t.Fatalf("status = %d, want %d", status, http.StatusInternalServerError)
	}
	if middleware.ErrorFromAuditState(ctx) != original {
		t.Fatal("original error was not recorded")
	}
	if state == nil {
		t.Fatal("audit state is nil")
	}

	response, ok := body.(types.ErrorResp)
	if !ok {
		t.Fatalf("body type = %T, want types.ErrorResp", body)
	}
	if response.Error.Code != "INTERNAL_ERROR" {
		t.Fatalf("error code = %q", response.Error.Code)
	}
	if response.Error.Message != "internal server error" {
		t.Fatalf("error message = %q", response.Error.Message)
	}
}

func TestConfiguredErrorHandlerWritesStandardJSON(t *testing.T) {
	ConfigureErrorHandler()
	t.Cleanup(func() { httpx.SetErrorHandlerCtx(nil) })

	recorder := httptest.NewRecorder()
	ctx := middleware.WithRequestID(context.Background(), "request-2")
	httpx.ErrorCtx(ctx, recorder, errors.New("database unavailable"))

	if recorder.Code != http.StatusInternalServerError {
		t.Fatalf("status = %d, want %d", recorder.Code, http.StatusInternalServerError)
	}
	var response types.ErrorResp
	if err := json.NewDecoder(recorder.Body).Decode(&response); err != nil {
		t.Fatalf("decode response: %v", err)
	}
	if response.Error.Code != "INTERNAL_ERROR" {
		t.Fatalf("error code = %q", response.Error.Code)
	}
	if response.Error.Message != "internal server error" {
		t.Fatalf("error message = %q", response.Error.Message)
	}
}

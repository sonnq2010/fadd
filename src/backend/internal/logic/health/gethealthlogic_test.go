package health

import (
	"context"
	"testing"

	"github.com/sonnq2010/fadd/src/backend/internal/config"
	"github.com/sonnq2010/fadd/src/backend/internal/svc"
)

func TestGetHealth(t *testing.T) {
	t.Parallel()

	logic := NewGetHealthLogic(context.Background(), &svc.ServiceContext{
		Config: config.Config{Version: "test-version"},
	})

	response, err := logic.GetHealth()
	if err != nil {
		t.Fatalf("GetHealth returned error: %v", err)
	}
	if response.Status != "ok" {
		t.Errorf("status = %q, want ok", response.Status)
	}
	if response.Version != "test-version" {
		t.Errorf("version = %q, want test-version", response.Version)
	}
}

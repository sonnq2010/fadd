//go:build integration

package repository

import (
	"context"
	"errors"
	"testing"
	"time"

	"github.com/google/uuid"

	"github.com/sonnq2010/fadd/src/backend/tests/testsupport"
)

func TestPostgresUserRepo(t *testing.T) {
	pool := testsupport.StartPostgres(t)
	ctx := context.Background()
	id := uuid.New()
	createdAt := time.Date(2026, time.August, 16, 12, 0, 0, 0, time.UTC)

	_, err := pool.Exec(ctx, `
		INSERT INTO users (id, email, display_name, created_at, updated_at)
		VALUES ($1, $2, $3, $4, $4)
	`, id, "user@example.com", "Example User", createdAt)
	if err != nil {
		t.Fatalf("insert user: %v", err)
	}

	repository := NewPostgresUserRepo(pool)
	user, err := repository.GetByID(ctx, id)
	if err != nil {
		t.Fatalf("GetByID returned error: %v", err)
	}
	if user.ID != id {
		t.Errorf("ID = %s, want %s", user.ID, id)
	}
	if user.Email != "user@example.com" {
		t.Errorf("email = %q", user.Email)
	}
	if user.DisplayName != "Example User" {
		t.Errorf("display name = %q", user.DisplayName)
	}
	if !user.CreatedAt.Equal(createdAt) {
		t.Errorf("created at = %s, want %s", user.CreatedAt, createdAt)
	}

	_, err = repository.GetByID(ctx, uuid.New())
	if !errors.Is(err, ErrNotFound) {
		t.Fatalf("missing user error = %v, want %v", err, ErrNotFound)
	}
}

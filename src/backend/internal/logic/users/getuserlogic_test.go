package users

import (
	"context"
	"errors"
	"testing"
	"time"

	"github.com/google/uuid"

	"github.com/sonnq2010/fadd/src/backend/internal/apperrors"
	"github.com/sonnq2010/fadd/src/backend/internal/repository"
	"github.com/sonnq2010/fadd/src/backend/internal/svc"
	"github.com/sonnq2010/fadd/src/backend/internal/types"
)

type fakeUserRepo struct {
	user   repository.User
	err    error
	id     uuid.UUID
	called bool
}

func (r *fakeUserRepo) GetByID(_ context.Context, id uuid.UUID) (repository.User, error) {
	r.called = true
	r.id = id
	return r.user, r.err
}

func TestGetUser(t *testing.T) {
	t.Parallel()

	id := uuid.New()
	createdAt := time.Date(2026, time.August, 16, 10, 30, 0, 123, time.FixedZone("test", 7*60*60))
	updatedAt := createdAt.Add(time.Hour)
	repositoryError := errors.New("database unavailable")

	tests := []struct {
		name           string
		request        *types.GetUserReq
		user           repository.User
		repositoryErr  error
		wantErr        error
		wantCode       string
		wantRepository bool
		checkResponse  func(*testing.T, *types.UserResp)
	}{
		{
			name:    "success",
			request: &types.GetUserReq{ID: id.String()},
			user: repository.User{
				ID:          id,
				Email:       "user@example.com",
				DisplayName: "Example User",
				CreatedAt:   createdAt,
				UpdatedAt:   updatedAt,
			},
			wantRepository: true,
			checkResponse: func(t *testing.T, response *types.UserResp) {
				t.Helper()
				if response.ID != id.String() {
					t.Errorf("response ID = %q, want %q", response.ID, id.String())
				}
				if response.Email != "user@example.com" {
					t.Errorf("response email = %q", response.Email)
				}
				if response.DisplayName != "Example User" {
					t.Errorf("response display name = %q", response.DisplayName)
				}
				if response.CreatedAt != createdAt.UTC().Format(time.RFC3339Nano) {
					t.Errorf("response createdAt = %q", response.CreatedAt)
				}
				if response.UpdatedAt != updatedAt.UTC().Format(time.RFC3339Nano) {
					t.Errorf("response updatedAt = %q", response.UpdatedAt)
				}
			},
		},
		{
			name:     "nil request",
			wantErr:  ErrInvalidUserID,
			wantCode: apperrors.CodeInvalidUserID,
		},
		{
			name:     "invalid id",
			request:  &types.GetUserReq{ID: "not-a-uuid"},
			wantErr:  ErrInvalidUserID,
			wantCode: apperrors.CodeInvalidUserID,
		},
		{
			name:           "not found",
			request:        &types.GetUserReq{ID: id.String()},
			repositoryErr:  repository.ErrNotFound,
			wantErr:        ErrUserNotFound,
			wantCode:       apperrors.CodeUserNotFound,
			wantRepository: true,
		},
		{
			name:           "repository failure",
			request:        &types.GetUserReq{ID: id.String()},
			repositoryErr:  repositoryError,
			wantErr:        repositoryError,
			wantCode:       apperrors.CodeInternalError,
			wantRepository: true,
		},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()

			fakeRepository := &fakeUserRepo{
				user: test.user,
				err:  test.repositoryErr,
			}
			logic := NewGetUserLogic(context.Background(), &svc.ServiceContext{UserRepo: fakeRepository})

			response, err := logic.GetUser(test.request)
			if !errors.Is(err, test.wantErr) {
				t.Fatalf("GetUser error = %v, want %v", err, test.wantErr)
			}
			if test.wantCode != "" {
				var appErr *apperrors.AppError
				if !errors.As(err, &appErr) {
					t.Fatalf("GetUser error = %T, want *apperrors.AppError", err)
				}
				if appErr.Code != test.wantCode {
					t.Fatalf("application error code = %q, want %q", appErr.Code, test.wantCode)
				}
			}
			if fakeRepository.called != test.wantRepository {
				t.Fatalf("repository called = %t, want %t", fakeRepository.called, test.wantRepository)
			}
			if test.wantRepository && fakeRepository.id != id {
				t.Fatalf("repository received id %s, want %s", fakeRepository.id, id)
			}
			if test.checkResponse != nil {
				test.checkResponse(t, response)
			}
		})
	}
}

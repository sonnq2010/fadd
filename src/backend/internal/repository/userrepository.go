package repository

import (
	"context"
	"errors"
	"fmt"
	"time"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"

	repositorysqlc "github.com/sonnq2010/fadd/src/backend/internal/repository/sqlc"
)

// ErrNotFound reports that a requested repository record does not exist.
var ErrNotFound = errors.New("repository: record not found")

// User is the repository-facing user model.
type User struct {
	ID          uuid.UUID
	Email       string
	DisplayName string
	CreatedAt   time.Time
	UpdatedAt   time.Time
}

// UserRepo defines persistence needed by user use cases.
type UserRepo interface {
	// GetByID loads one user by primary key.
	GetByID(ctx context.Context, id uuid.UUID) (User, error)
}

// PostgresUserRepo stores users through sqlc-generated PostgreSQL queries.
type PostgresUserRepo struct {
	queries *repositorysqlc.Queries
}

// NewPostgresUserRepo creates a PostgreSQL user repository.
func NewPostgresUserRepo(db repositorysqlc.DBTX) *PostgresUserRepo {
	return &PostgresUserRepo{
		queries: repositorysqlc.New(db),
	}
}

// GetByID loads one user by primary key.
func (r *PostgresUserRepo) GetByID(ctx context.Context, id uuid.UUID) (User, error) {
	user, err := r.queries.GetUser(ctx, id)
	if errors.Is(err, pgx.ErrNoRows) {
		return User{}, ErrNotFound
	}
	if err != nil {
		return User{}, fmt.Errorf("query user: %w", err)
	}

	return User{
		ID:          user.ID,
		Email:       user.Email,
		DisplayName: user.DisplayName,
		CreatedAt:   user.CreatedAt,
		UpdatedAt:   user.UpdatedAt,
	}, nil
}

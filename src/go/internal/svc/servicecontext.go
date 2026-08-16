// Code scaffolded by goctl. Safe to edit.
// goctl 1.10.1

package svc

import (
	"context"
	"fmt"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/zeromicro/go-zero/rest"

	"github.com/sonnq2010/fadd/src/go/internal/config"
	"github.com/sonnq2010/fadd/src/go/internal/middleware"
	"github.com/sonnq2010/fadd/src/go/internal/repository"
)

// ServiceContext owns dependencies shared by handlers and logic.
type ServiceContext struct {
	Config   config.Config
	DB       *pgxpool.Pool
	UserRepo repository.UserRepo
	Auth     rest.Middleware
}

// NewServiceContext creates production dependencies and verifies database connectivity.
func NewServiceContext(ctx context.Context, c config.Config) (*ServiceContext, error) {
	pool, err := pgxpool.New(ctx, c.Database.DataSource)
	if err != nil {
		return nil, fmt.Errorf("create PostgreSQL pool: %w", err)
	}
	if err := pool.Ping(ctx); err != nil {
		pool.Close()
		return nil, fmt.Errorf("ping PostgreSQL: %w", err)
	}

	return NewServiceContextWithPool(c, pool), nil
}

// NewServiceContextWithPool creates dependencies from an existing pool.
func NewServiceContextWithPool(c config.Config, pool *pgxpool.Pool) *ServiceContext {
	return &ServiceContext{
		Config:   c,
		DB:       pool,
		UserRepo: repository.NewPostgresUserRepo(pool),
		Auth:     middleware.NewAuthMiddleware().Handle,
	}
}

// Close releases resources owned by the service context.
func (s *ServiceContext) Close() {
	if s.DB != nil {
		s.DB.Close()
	}
}

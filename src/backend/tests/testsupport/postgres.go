package testsupport

import (
	"context"
	"database/sql"
	"path/filepath"
	"runtime"
	"testing"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
	_ "github.com/jackc/pgx/v5/stdlib"
	"github.com/pressly/goose/v3"
	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/modules/postgres"
)

// StartPostgres starts PostgreSQL, applies Goose migrations, and returns a pool.
func StartPostgres(t *testing.T) *pgxpool.Pool {
	t.Helper()

	ctx, cancel := context.WithTimeout(context.Background(), 2*time.Minute)
	t.Cleanup(cancel)

	container, err := postgres.Run(
		ctx,
		"postgres:18-alpine",
		postgres.WithDatabase("fadd"),
		postgres.WithUsername("postgres"),
		postgres.WithPassword("postgres"),
		postgres.BasicWaitStrategies(),
	)
	if err != nil {
		t.Fatalf("start PostgreSQL container: %v", err)
	}
	t.Cleanup(func() {
		if err := testcontainers.TerminateContainer(container); err != nil {
			t.Errorf("terminate PostgreSQL container: %v", err)
		}
	})

	dataSource, err := container.ConnectionString(ctx, "sslmode=disable")
	if err != nil {
		t.Fatalf("build PostgreSQL connection string: %v", err)
	}

	migrate(t, ctx, dataSource)

	pool, err := pgxpool.New(ctx, dataSource)
	if err != nil {
		t.Fatalf("create PostgreSQL pool: %v", err)
	}
	if err := pool.Ping(ctx); err != nil {
		pool.Close()
		t.Fatalf("ping PostgreSQL: %v", err)
	}
	t.Cleanup(pool.Close)

	return pool
}

func migrate(t *testing.T, ctx context.Context, dataSource string) {
	t.Helper()

	database, err := sql.Open("pgx", dataSource)
	if err != nil {
		t.Fatalf("open migration database: %v", err)
	}
	defer func() {
		if err := database.Close(); err != nil {
			t.Errorf("close migration database: %v", err)
		}
	}()

	if err := goose.SetDialect("postgres"); err != nil {
		t.Fatalf("set Goose dialect: %v", err)
	}

	_, currentFile, _, ok := runtime.Caller(0)
	if !ok {
		t.Fatal("resolve migration directory")
	}
	migrationDirectory := filepath.Join(filepath.Dir(currentFile), "..", "..", "migrations")

	if err := goose.UpContext(ctx, database, migrationDirectory); err != nil {
		t.Fatalf("run Goose migrations: %v", err)
	}
}

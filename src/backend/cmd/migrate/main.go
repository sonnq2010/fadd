package main

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"log"
	"os"

	"github.com/pressly/goose/v3"
	"github.com/sonnq2010/fadd/src/backend/internal/config"

	_ "github.com/jackc/pgx/v5/stdlib"
)

const migrationsDirectory = "migrations"

func main() {
	if err := run(context.Background(), os.Args[1:]); err != nil {
		log.Fatal(err)
	}
}

func run(ctx context.Context, args []string) (err error) {
	action := "up"
	if len(args) > 1 {
		return fmt.Errorf("usage: migrate [up|down|status]")
	}
	if len(args) == 1 {
		action = args[0]
	}
	if action != "up" && action != "down" && action != "status" {
		return fmt.Errorf("unsupported migration action %q", action)
	}

	dataSource, err := config.DatabaseDataSourceFromEnvironment()
	if err != nil {
		return fmt.Errorf("resolve database configuration: %w", err)
	}

	database, err := sql.Open("pgx", dataSource)
	if err != nil {
		return fmt.Errorf("open database: %w", err)
	}
	defer func() {
		err = errors.Join(err, database.Close())
	}()

	if err := goose.SetDialect("postgres"); err != nil {
		return fmt.Errorf("configure migration dialect: %w", err)
	}

	switch action {
	case "up":
		err = goose.UpContext(ctx, database, migrationsDirectory)
	case "down":
		err = goose.DownContext(ctx, database, migrationsDirectory)
	case "status":
		err = goose.StatusContext(ctx, database, migrationsDirectory)
	}
	if err != nil {
		return fmt.Errorf("run migration %s: %w", action, err)
	}

	return nil
}

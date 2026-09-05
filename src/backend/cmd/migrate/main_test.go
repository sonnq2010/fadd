package main

import (
	"context"
	"os"
	"strings"
	"testing"
)

func TestRunRejectsUnsupportedActionBeforeDatabaseAccess(t *testing.T) {
	err := run(context.Background(), []string{"invalid"})
	if err == nil || !strings.Contains(err.Error(), "unsupported migration action") {
		t.Fatalf("error = %v, want unsupported action", err)
	}
}

func TestRunRequiresDatabaseEnvironment(t *testing.T) {
	unsetDatabaseEnvironment(t)
	err := run(context.Background(), nil)
	if err == nil || !strings.Contains(err.Error(), "missing required database environment variables") {
		t.Fatalf("error = %v, want missing environment error", err)
	}
}

func unsetDatabaseEnvironment(t *testing.T) {
	t.Helper()
	for _, name := range []string{
		"POSTGRES_USER",
		"POSTGRES_PASSWORD",
		"POSTGRES_DB",
		"POSTGRES_HOST",
		"POSTGRES_PORT",
		"POSTGRES_SSLMODE",
	} {
		value, exists := os.LookupEnv(name)
		if err := os.Unsetenv(name); err != nil {
			t.Fatalf("unset %s: %v", name, err)
		}
		t.Cleanup(func() {
			if exists {
				_ = os.Setenv(name, value)
			} else {
				_ = os.Unsetenv(name)
			}
		})
	}
}

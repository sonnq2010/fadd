package config

import (
	"net/url"
	"os"
	"strings"
	"testing"
)

func TestApplyEnvironmentUsesPostgresVariables(t *testing.T) {
	setPostgresEnvironment(t, map[string]string{
		"POSTGRES_USER":     "application",
		"POSTGRES_PASSWORD": "secret",
		"POSTGRES_DB":       "fadd",
		"POSTGRES_HOST":     "database.internal",
		"POSTGRES_PORT":     "5432",
		"POSTGRES_SSLMODE":  "require",
	})
	configuration := Config{}

	if err := configuration.ApplyEnvironment(); err != nil {
		t.Fatalf("apply environment: %v", err)
	}

	if configuration.Database.DataSource != "postgres://application:secret@database.internal:5432/fadd?sslmode=require" {
		t.Fatalf("data source = %q", configuration.Database.DataSource)
	}
}

func TestDatabaseDataSourceFromEnvironmentEscapesValues(t *testing.T) {
	setPostgresEnvironment(t, map[string]string{
		"POSTGRES_USER":     "app:user",
		"POSTGRES_PASSWORD": "p@ss:/%?# word",
		"POSTGRES_DB":       "fadd/test",
		"POSTGRES_HOST":     "2001:db8::1",
		"POSTGRES_PORT":     "5432",
		"POSTGRES_SSLMODE":  "verify-full",
	})

	dataSource, err := DatabaseDataSourceFromEnvironment()
	if err != nil {
		t.Fatalf("build data source: %v", err)
	}

	parsed, err := url.Parse(dataSource)
	if err != nil {
		t.Fatalf("parse data source: %v", err)
	}
	password, ok := parsed.User.Password()
	if !ok || parsed.User.Username() != "app:user" || password != "p@ss:/%?# word" {
		t.Fatalf("credentials were not preserved")
	}
	if parsed.Hostname() != "2001:db8::1" || parsed.Port() != "5432" {
		t.Fatalf("host = %q, want IPv6 host and port", parsed.Host)
	}
	if parsed.Path != "/fadd/test" || parsed.Query().Get("sslmode") != "verify-full" {
		t.Fatalf("path/query = %q/%q", parsed.Path, parsed.RawQuery)
	}
}

func TestApplyEnvironmentRejectsPartialDatabaseConfiguration(t *testing.T) {
	setPostgresEnvironment(t, map[string]string{"POSTGRES_PASSWORD": "do-not-leak"})
	configuration := Config{}

	err := configuration.ApplyEnvironment()
	if err == nil {
		t.Fatal("expected incomplete database environment to fail")
	}
	if strings.Contains(err.Error(), "do-not-leak") {
		t.Fatal("error contains database password")
	}
	if !strings.Contains(err.Error(), "POSTGRES_HOST") {
		t.Fatalf("error = %q, want missing variable names", err)
	}
}

func TestApplyEnvironmentRejectsInvalidDatabaseValues(t *testing.T) {
	tests := []struct {
		name     string
		override map[string]string
		want     string
	}{
		{name: "non numeric port", override: map[string]string{"POSTGRES_PORT": "invalid"}, want: "POSTGRES_PORT"},
		{name: "port out of range", override: map[string]string{"POSTGRES_PORT": "65536"}, want: "POSTGRES_PORT"},
		{name: "invalid ssl mode", override: map[string]string{"POSTGRES_SSLMODE": "encrypted"}, want: "POSTGRES_SSLMODE"},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			values := validPostgresEnvironment()
			for name, value := range test.override {
				values[name] = value
			}
			setPostgresEnvironment(t, values)

			_, err := DatabaseDataSourceFromEnvironment()
			if err == nil || !strings.Contains(err.Error(), test.want) {
				t.Fatalf("error = %v, want %s validation error", err, test.want)
			}
		})
	}
}

func TestApplyEnvironmentOverridesRuntimePort(t *testing.T) {
	setPostgresEnvironment(t, validPostgresEnvironment())
	t.Setenv("PORT", "8080")
	configuration := Config{}
	configuration.Port = 8888

	if err := configuration.ApplyEnvironment(); err != nil {
		t.Fatalf("apply environment: %v", err)
	}

	if configuration.Port != 8080 {
		t.Fatalf("port = %d, want 8080", configuration.Port)
	}
}

func TestApplyEnvironmentRequiresPostgresEnvironment(t *testing.T) {
	unsetPostgresEnvironment(t)
	configuration := Config{}

	err := configuration.ApplyEnvironment()
	if err == nil {
		t.Fatal("expected missing database environment to fail")
	}
	for _, name := range postgresEnvironmentNames {
		if !strings.Contains(err.Error(), name) {
			t.Fatalf("error = %q, want %s", err, name)
		}
	}
}

func setPostgresEnvironment(t *testing.T, values map[string]string) {
	t.Helper()
	for _, name := range postgresEnvironmentNames {
		t.Setenv(name, values[name])
	}
}

func validPostgresEnvironment() map[string]string {
	return map[string]string{
		"POSTGRES_USER":     "application",
		"POSTGRES_PASSWORD": "secret",
		"POSTGRES_DB":       "fadd",
		"POSTGRES_HOST":     "database.internal",
		"POSTGRES_PORT":     "5432",
		"POSTGRES_SSLMODE":  "require",
	}
}

func unsetPostgresEnvironment(t *testing.T) {
	t.Helper()
	for _, name := range postgresEnvironmentNames {
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

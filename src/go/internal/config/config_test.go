package config

import "testing"

func TestApplyEnvironment(t *testing.T) {
	t.Setenv("DATABASE_URL", "postgres://environment")
	configuration := Config{
		Database: DatabaseConfig{DataSource: "postgres://file"},
	}

	configuration.ApplyEnvironment()

	if configuration.Database.DataSource != "postgres://environment" {
		t.Fatalf("data source = %q, want environment value", configuration.Database.DataSource)
	}
}

func TestApplyEnvironmentKeepsFileValueWhenEnvironmentIsEmpty(t *testing.T) {
	t.Setenv("DATABASE_URL", "")
	configuration := Config{
		Database: DatabaseConfig{DataSource: "postgres://file"},
	}

	configuration.ApplyEnvironment()

	if configuration.Database.DataSource != "postgres://file" {
		t.Fatalf("data source = %q, want file value", configuration.Database.DataSource)
	}
}

// Code scaffolded by goctl. Safe to edit.
// goctl 1.10.1

package config

import (
	"os"

	"github.com/zeromicro/go-zero/rest"
)

// DatabaseConfig contains PostgreSQL connection settings.
type DatabaseConfig struct {
	DataSource string
}

// Config contains service runtime configuration.
type Config struct {
	rest.RestConf
	Version  string
	Database DatabaseConfig
}

// ApplyEnvironment overrides secret-bearing settings from process environment.
func (c *Config) ApplyEnvironment() {
	if dataSource := os.Getenv("DATABASE_URL"); dataSource != "" {
		c.Database.DataSource = dataSource
	}
}

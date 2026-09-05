// Code scaffolded by goctl. Safe to edit.
// goctl 1.10.1

package config

import (
	"fmt"
	"net"
	"net/url"
	"os"
	"sort"
	"strconv"
	"strings"

	"github.com/zeromicro/go-zero/rest"
)

var postgresEnvironmentNames = []string{
	"POSTGRES_USER",
	"POSTGRES_PASSWORD",
	"POSTGRES_DB",
	"POSTGRES_HOST",
	"POSTGRES_PORT",
	"POSTGRES_SSLMODE",
}

var postgresSSLModes = map[string]struct{}{
	"allow":       {},
	"disable":     {},
	"prefer":      {},
	"require":     {},
	"verify-ca":   {},
	"verify-full": {},
}

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

// ApplyEnvironment overrides runtime settings from process environment.
func (c *Config) ApplyEnvironment() error {
	dataSource, err := DatabaseDataSourceFromEnvironment()
	if err != nil {
		return err
	}
	c.Database.DataSource = dataSource

	if port, err := strconv.Atoi(os.Getenv("PORT")); err == nil && port > 0 {
		c.Port = port
	}

	return nil
}

// DatabaseDataSourceFromEnvironment builds a PostgreSQL URL from POSTGRES_* variables.
func DatabaseDataSourceFromEnvironment() (string, error) {
	values := make(map[string]string, len(postgresEnvironmentNames))
	missing := make([]string, 0, len(postgresEnvironmentNames))

	for _, name := range postgresEnvironmentNames {
		values[name] = os.Getenv(name)
	}
	for _, name := range postgresEnvironmentNames {
		value := values[name]
		if name != "POSTGRES_PASSWORD" {
			value = strings.TrimSpace(value)
			values[name] = value
		}
		if value == "" {
			missing = append(missing, name)
		}
	}
	if len(missing) > 0 {
		sort.Strings(missing)
		return "", fmt.Errorf("missing required database environment variables: %s", strings.Join(missing, ", "))
	}

	port, err := strconv.Atoi(values["POSTGRES_PORT"])
	if err != nil || port < 1 || port > 65535 {
		return "", fmt.Errorf("POSTGRES_PORT must be an integer between 1 and 65535")
	}

	sslMode := values["POSTGRES_SSLMODE"]
	if _, ok := postgresSSLModes[sslMode]; !ok {
		return "", fmt.Errorf("POSTGRES_SSLMODE must be one of disable, allow, prefer, require, verify-ca, or verify-full")
	}

	databaseName := values["POSTGRES_DB"]
	connectionURL := &url.URL{
		Scheme:  "postgres",
		User:    url.UserPassword(values["POSTGRES_USER"], values["POSTGRES_PASSWORD"]),
		Host:    net.JoinHostPort(values["POSTGRES_HOST"], strconv.Itoa(port)),
		Path:    "/" + databaseName,
		RawPath: "/" + url.PathEscape(databaseName),
	}
	query := connectionURL.Query()
	query.Set("sslmode", sslMode)
	connectionURL.RawQuery = query.Encode()

	return connectionURL.String(), nil
}

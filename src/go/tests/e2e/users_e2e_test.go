//go:build e2e

package e2e

import (
	"context"
	"encoding/json"
	"fmt"
	"net"
	"net/http"
	"testing"
	"time"

	"github.com/google/uuid"
	"github.com/zeromicro/go-zero/core/service"
	"github.com/zeromicro/go-zero/rest"

	"github.com/sonnq2010/fadd/src/go/internal/config"
	"github.com/sonnq2010/fadd/src/go/internal/handler"
	"github.com/sonnq2010/fadd/src/go/internal/svc"
	"github.com/sonnq2010/fadd/src/go/internal/types"
	"github.com/sonnq2010/fadd/src/go/tests/testsupport"
)

func TestUsersVerticalSlice(t *testing.T) {
	pool := testsupport.StartPostgres(t)
	id := uuid.New()

	_, err := pool.Exec(context.Background(), `
		INSERT INTO users (id, email, display_name)
		VALUES ($1, $2, $3)
	`, id, "user@example.com", "Example User")
	if err != nil {
		t.Fatalf("insert user: %v", err)
	}

	port := freePort(t)
	applicationConfig := config.Config{
		RestConf: rest.RestConf{
			ServiceConf: service.ServiceConf{Name: "backend-api-test"},
			Host:        "127.0.0.1",
			Port:        port,
			Timeout:     3000,
		},
		Version: "test-version",
	}
	serviceContext := svc.NewServiceContextWithPool(applicationConfig, pool)
	server := rest.MustNewServer(applicationConfig.RestConf)
	handler.RegisterHandlers(server, serviceContext)

	go server.Start()
	t.Cleanup(server.Stop)

	baseURL := fmt.Sprintf("http://127.0.0.1:%d/api/v1", port)
	waitForServer(t, baseURL+"/health")

	healthResponse, err := http.Get(baseURL + "/health")
	if err != nil {
		t.Fatalf("GET health: %v", err)
	}
	defer healthResponse.Body.Close()
	if healthResponse.StatusCode != http.StatusOK {
		t.Fatalf("health status = %d, want %d", healthResponse.StatusCode, http.StatusOK)
	}

	userResponse, err := http.Get(baseURL + "/users/" + id.String())
	if err != nil {
		t.Fatalf("GET user: %v", err)
	}
	defer userResponse.Body.Close()
	if userResponse.StatusCode != http.StatusOK {
		t.Fatalf("user status = %d, want %d", userResponse.StatusCode, http.StatusOK)
	}

	var user types.UserResp
	if err := json.NewDecoder(userResponse.Body).Decode(&user); err != nil {
		t.Fatalf("decode user response: %v", err)
	}
	if user.ID != id.String() {
		t.Errorf("user ID = %q, want %q", user.ID, id.String())
	}
	if user.Email != "user@example.com" {
		t.Errorf("user email = %q", user.Email)
	}
	if user.DisplayName != "Example User" {
		t.Errorf("user display name = %q", user.DisplayName)
	}
}

func freePort(t *testing.T) int {
	t.Helper()

	listener, err := net.Listen("tcp", "127.0.0.1:0")
	if err != nil {
		t.Fatalf("allocate port: %v", err)
	}
	defer listener.Close()

	return listener.Addr().(*net.TCPAddr).Port
}

func waitForServer(t *testing.T, url string) {
	t.Helper()

	deadline := time.Now().Add(5 * time.Second)
	for time.Now().Before(deadline) {
		response, err := http.Get(url)
		if err == nil {
			response.Body.Close()
			if response.StatusCode == http.StatusOK {
				return
			}
		}
		time.Sleep(25 * time.Millisecond)
	}

	t.Fatalf("server did not become ready at %s", url)
}

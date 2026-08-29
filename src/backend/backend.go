// Code scaffolded by goctl. Safe to edit.
// goctl 1.10.1

package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/zeromicro/go-zero/core/conf"
	"github.com/zeromicro/go-zero/rest"

	"github.com/sonnq2010/fadd/src/backend/internal/config"
	"github.com/sonnq2010/fadd/src/backend/internal/handler"
	"github.com/sonnq2010/fadd/src/backend/internal/middleware/auditlog"
	"github.com/sonnq2010/fadd/src/backend/internal/svc"
)

var configFile = flag.String("f", "etc/backend-api.yaml", "the config file")

func methodNotAllowed(w http.ResponseWriter, _ *http.Request) {
	http.Error(w, http.StatusText(http.StatusMethodNotAllowed), http.StatusMethodNotAllowed)
}

func main() {
	flag.Parse()

	var c config.Config
	conf.MustLoad(*configFile, &c)
	c.ApplyEnvironment()
	c.Middlewares.Log = false

	auditMiddleware := auditlog.NewRequestAuditMiddleware()
	server := rest.MustNewServer(c.RestConf,
		rest.WithNotFoundHandler(auditMiddleware.Handle(http.NotFoundHandler().ServeHTTP)),
		rest.WithNotAllowedHandler(auditMiddleware.Handle(methodNotAllowed)),
	)
	defer server.Stop()

	startupContext, cancelStartup := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancelStartup()

	serviceContext, err := svc.NewServiceContext(startupContext, c)
	if err != nil {
		log.Fatalf("create service context: %v", err)
	}
	defer serviceContext.Close()

	server.Use(auditMiddleware.Handle)

	handler.RegisterHandlers(server, serviceContext)

	fmt.Printf("Starting server at %s:%d...\n", c.Host, c.Port)
	server.Start()
}

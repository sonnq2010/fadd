// Code scaffolded by goctl. Safe to edit.
// goctl 1.10.1

package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"time"

	"github.com/zeromicro/go-zero/core/conf"
	"github.com/zeromicro/go-zero/rest"

	"github.com/sonnq2010/fadd/src/go/internal/config"
	"github.com/sonnq2010/fadd/src/go/internal/handler"
	"github.com/sonnq2010/fadd/src/go/internal/svc"
)

var configFile = flag.String("f", "etc/backend-api.yaml", "the config file")

func main() {
	flag.Parse()

	var c config.Config
	conf.MustLoad(*configFile, &c)
	c.ApplyEnvironment()

	server := rest.MustNewServer(c.RestConf)
	defer server.Stop()

	startupContext, cancelStartup := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancelStartup()

	serviceContext, err := svc.NewServiceContext(startupContext, c)
	if err != nil {
		log.Fatalf("create service context: %v", err)
	}
	defer serviceContext.Close()

	handler.RegisterHandlers(server, serviceContext)

	fmt.Printf("Starting server at %s:%d...\n", c.Host, c.Port)
	server.Start()
}

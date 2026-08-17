// Code scaffolded by goctl. Safe to edit.
// goctl 1.10.1

package health

import (
	"context"

	"github.com/zeromicro/go-zero/core/logx"

	"github.com/sonnq2010/fadd/src/backend/internal/svc"
	"github.com/sonnq2010/fadd/src/backend/internal/types"
)

// GetHealthLogic returns process liveness metadata.
type GetHealthLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

// NewGetHealthLogic creates health logic.
func NewGetHealthLogic(ctx context.Context, svcCtx *svc.ServiceContext) *GetHealthLogic {
	return &GetHealthLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// GetHealth returns current service status and version.
func (l *GetHealthLogic) GetHealth() (*types.HealthResp, error) {
	return &types.HealthResp{
		Status:  "ok",
		Version: l.svcCtx.Config.Version,
	}, nil
}

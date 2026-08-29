// Code scaffolded by goctl. Safe to edit.
// goctl 1.10.1

package users

import (
	"context"
	"errors"
	"time"

	"github.com/google/uuid"

	"github.com/sonnq2010/fadd/src/backend/internal/apperrors"
	"github.com/zeromicro/go-zero/core/logx"

	"github.com/sonnq2010/fadd/src/backend/internal/repository"
	"github.com/sonnq2010/fadd/src/backend/internal/svc"
	"github.com/sonnq2010/fadd/src/backend/internal/types"
)

var (
	// ErrInvalidUserID reports a malformed user identifier.
	ErrInvalidUserID = errors.New("invalid user id")
	// ErrUserNotFound reports that the requested user does not exist.
	ErrUserNotFound = errors.New("user not found")
)

// GetUserLogic coordinates the user lookup use case.
type GetUserLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

// NewGetUserLogic creates user lookup logic.
func NewGetUserLogic(ctx context.Context, svcCtx *svc.ServiceContext) *GetUserLogic {
	return &GetUserLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// GetUser validates a user ID and returns its API representation.
func (l *GetUserLogic) GetUser(req *types.GetUserReq) (*types.UserResp, error) {
	if req == nil {
		return nil, apperrors.InvalidUserID(ErrInvalidUserID)
	}

	id, err := uuid.Parse(req.ID)
	if err != nil {
		return nil, apperrors.InvalidUserID(ErrInvalidUserID)
	}

	user, err := l.svcCtx.UserRepo.GetByID(l.ctx, id)
	if errors.Is(err, repository.ErrNotFound) {
		return nil, apperrors.UserNotFound(ErrUserNotFound)
	}
	if err != nil {
		return nil, apperrors.WrapInternal("get user", err)
	}

	return &types.UserResp{
		ID:          user.ID.String(),
		Email:       user.Email,
		DisplayName: user.DisplayName,
		CreatedAt:   user.CreatedAt.UTC().Format(time.RFC3339Nano),
		UpdatedAt:   user.UpdatedAt.UTC().Format(time.RFC3339Nano),
	}, nil
}

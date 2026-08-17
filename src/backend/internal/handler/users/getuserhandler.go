// Code scaffolded by goctl. Safe to edit.
// goctl 1.10.1

package users

import (
	"net/http"

	"github.com/sonnq2010/fadd/src/backend/internal/logic/users"
	"github.com/sonnq2010/fadd/src/backend/internal/svc"
	"github.com/sonnq2010/fadd/src/backend/internal/types"
	"github.com/zeromicro/go-zero/rest/httpx"
)

func GetUserHandler(svcCtx *svc.ServiceContext) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req types.GetUserReq
		if err := httpx.Parse(r, &req); err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
			return
		}

		l := users.NewGetUserLogic(r.Context(), svcCtx)
		resp, err := l.GetUser(&req)
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.OkJsonCtx(r.Context(), w, resp)
		}
	}
}

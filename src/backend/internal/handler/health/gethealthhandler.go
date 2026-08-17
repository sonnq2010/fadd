// Code scaffolded by goctl. Safe to edit.
// goctl 1.10.1

package health

import (
	"net/http"

	"github.com/sonnq2010/fadd/src/backend/internal/logic/health"
	"github.com/sonnq2010/fadd/src/backend/internal/svc"
	"github.com/zeromicro/go-zero/rest/httpx"
)

func GetHealthHandler(svcCtx *svc.ServiceContext) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		l := health.NewGetHealthLogic(r.Context(), svcCtx)
		resp, err := l.GetHealth()
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.OkJsonCtx(r.Context(), w, resp)
		}
	}
}

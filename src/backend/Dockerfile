# syntax=docker/dockerfile:1.7

FROM golang:1.26.3-alpine AS build
WORKDIR /src
RUN apk add --no-cache ca-certificates git
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o /out/backend .
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o /out/migrate ./cmd/migrate

FROM gcr.io/distroless/static-debian13:nonroot AS api
WORKDIR /app
COPY --from=build /out/backend /app/backend
COPY --from=build /src/etc /app/etc
EXPOSE 8888
ENTRYPOINT ["/app/backend"]

FROM gcr.io/distroless/static-debian13:nonroot AS migrations
WORKDIR /app
COPY --from=build /out/migrate /app/migrate
COPY --from=build /src/migrations /app/migrations
ENTRYPOINT ["/app/migrate"]
CMD ["up"]

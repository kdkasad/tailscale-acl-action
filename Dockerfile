FROM alpine:3.22 AS builder
RUN apk update
RUN apk add go
RUN --mount=type=cache,target=/root/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go install tailscale.com/cmd/gitops-pusher@v1.84.2

FROM alpine:3.22
COPY --from=builder /root/go/bin/gitops-pusher /usr/local/bin/gitops-pusher
ENTRYPOINT ["gitops-pusher"]

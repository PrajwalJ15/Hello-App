FROM    golang:1.19.2 as builder
WORKDIR /app
RUN     go mod init hello-app
COPY    *.go ./
RUN     CGO_ENABLED=0 GOOS=linux go build -o /hello-app

FROM    alpine:3
WORKDIR /
COPY    --from=builder /hello-app /hello-app
ENV     PORT 8080
CMD     ["/hello-app"]

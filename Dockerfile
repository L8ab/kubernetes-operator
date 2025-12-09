FROM golang:1.21 as builder
WORKDIR /workspace
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -o manager main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /workspace/manager .
ENTRYPOINT ["./manager"]

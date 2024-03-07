FROM golang:1.21-alpine AS build-stage

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY *.go .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /app/goapp

FROM scratch AS build-release-stage

WORKDIR /

COPY --from=build-stage /app/goapp /goapp

ENTRYPOINT [ "/goapp" ]


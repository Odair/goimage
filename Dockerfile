FROM golang:1.21 AS build-stage

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY *.go .

RUN CGO_ENABLED=0 GOOS=linux go build -o /app/goapp

FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR /

COPY --from=build-stage /app/goapp /goapp

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT [ "/goapp" ]


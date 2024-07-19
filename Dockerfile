FROM golang:1.22-alpine AS build

WORKDIR /usr/src/app

COPY go.mod main.go ./

RUN go mod download && go mod verify

RUN go build -v -o /app

FROM scratch

WORKDIR /

COPY --from=build /app /app

EXPOSE 8080

ENTRYPOINT ["/app"]
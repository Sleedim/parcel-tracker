FROM golang:1.25.3-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o parcel-tracker .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/parcel-tracker .
COPY tracker.db .

CMD ["./parcel-tracker"]
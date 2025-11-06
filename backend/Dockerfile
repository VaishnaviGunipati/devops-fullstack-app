# Stage 1: Build
FROM golang:1.19-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o main .

# Stage 2: Run
FROM alpine:latest
WORKDIR /root/

COPY --from=builder /app/main .

# Set environment variables (these can be overridden during deployment)
ENV PORT=8080
ENV DB_HOST=localhost
ENV DB_USER=admin
ENV DB_PASSWORD=admin123
ENV DB_NAME=employees
ENV DB_PORT=5432
ENV ALLOWED_ORIGINS=http://localhost

EXPOSE 8080
CMD ["./main"]



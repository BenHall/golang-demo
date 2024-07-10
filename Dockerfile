# First stage: build the application
FROM golang:1.21-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy go.mod
COPY go.mod go.sum ./

# Download dependencies and generate go.sum
RUN go mod download && go mod tidy

# Copy the rest of the application code
COPY . .

# Build the application
RUN go build -o myapp

# Second stage: create the runtime image
FROM alpine:latest

# Set the working directory
WORKDIR /root/

# Copy the built application from the builder stage
COPY --from=builder /app/myapp .

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./myapp"]

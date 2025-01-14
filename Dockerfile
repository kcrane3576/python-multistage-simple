# Stage 1: Build the application
FROM python:3.9@sha256:bf34ca456ffb53711f97f439a9f8879e00f16c81acde803d32fc4fad340b5234 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:273e4ed627676a69477c2843dcacf4f6c6b25946b3168b45e2292e73af5b45c1

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

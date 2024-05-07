# Stage 1: Build the application
FROM python:3.9@sha256:b81bfd63a766f385494a585e154465bb7178c820c4cd1e9cb6a8c3daa62433b7 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:2e1f1541f093ecfd3bda3388cedeb5034e73cfe0d36a124d55744ae926fa6be0

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

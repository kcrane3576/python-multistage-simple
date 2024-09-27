# Stage 1: Build the application
FROM python:3.9@sha256:76ae924c1a748c74aaa3f9240f431a4c31a618f5201bb8cab86a1f90dba07316 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:4173046fbca6dcfcf8a1fee7bb45f1c6cf8f3897639d4b36954911f661f62b4e

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

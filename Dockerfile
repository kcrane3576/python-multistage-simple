# Stage 1: Build the application
FROM python:3.9@sha256:c473340824cbcae7c63ca5c1e572f0eee09aea73b55f693f73632c218ada6429 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:6f5e0bebd8f1b2de0b117c638bb123f70fd9a5a39eb4b79e1323a9f4f3c2bdaf

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

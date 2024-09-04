# Stage 1: Build the application
FROM python:3.9@sha256:508857ffdc21ed516ff1e3a382d8a0f0aa11ca6a77640e4bb6c43502ae638a16 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:c3d85fdb27147947b88743537e1fcc83b8754f7cce06c1df35abe6a916c84e11

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

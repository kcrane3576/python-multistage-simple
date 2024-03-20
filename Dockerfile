# Stage 1: Build the application
FROM python:3.9@sha256:0c9a8ddadff127b5ac8a33474054612d3ad43e9e3d58ecd79795bd9bb60901aa AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:f38dc0b18a4f0f8e865e543a5a5d21b0a288aeaf47ef9a87727a0c5cf6737eff

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

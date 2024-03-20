# Stage 1: Build the application
FROM python:3.9@sha256:1023bd4c5e0e6b7f4f612b034627826d91ec78ae0439313450ec30c0ad60c908 AS builder

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

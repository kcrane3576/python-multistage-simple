# Stage 1: Build the application
FROM python:3.9@sha256:ebb54bb7c6353b9dc0c04cd6cab6a32501fa71c8cd6eb4cbfe9e7f648ce3c152 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:b8823f116c1502b1a5c5b8937d3638124f7fb07c6f4d1da97ded22e58b244ff7

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

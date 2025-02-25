# Stage 1: Build the application
FROM python:3.9@sha256:e5474a862a86c7cff39922f1ec2420ad1cd871bc1388456b9fd6cfcc38a6c2c3 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:6d268add0e4d164e41e366f226a10068db3ab78c967ede668ab1252f5702dedb

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

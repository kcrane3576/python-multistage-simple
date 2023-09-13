# Stage 1: Build the application
FROM python:3.9@sha256:40582fe697811beb7bfceef2087416336faa990fd7e24984a7c18a86d3423d58 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:3b4e3a36cce74c444b333a26958d65d08b0ded00869f1557faffe8d131a0bdc6

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

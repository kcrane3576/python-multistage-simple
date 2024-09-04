# Stage 1: Build the application
FROM python:3.9@sha256:f95306c46d09263f03c65e2187bcc71fffb84c7a90d1f6f7fc8272c311a2b738 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:50a5923556b47e76486fa49d6a5c0f46df58e3cec7842e03d965d7adb5c8b903

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

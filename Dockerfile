# Stage 1: Build the application
FROM python:3.9@sha256:f291d663f43111dfd62960ff6c5124745551a4199f5fe37b34ac8022a7489db0 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:0ec22bf3dda1dfc4d064155fb3f5ed5d9eeda758c80ccc71804df3b7743a5d0a

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

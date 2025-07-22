# Stage 1: Build the application
FROM python:3.9@sha256:a7df45d65b02458dcf4b2eba02094cfb076b2c6b451bc99cbc0edd0062b5142f AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:1db7925bad78f39e4bc64e2ffbfcc415e9c9eafa5ae4177d1f93e819ca47352d

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

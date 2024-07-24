# Stage 1: Build the application
FROM python:3.9@sha256:8a471a2dae20c7454ffa21047839f97816fc9c87f1f582fad18dec4589719ca0 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:9665a8203d12beec5f67603ccc3eadd59e89e5bab1dad13e1428c427e4ade990

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

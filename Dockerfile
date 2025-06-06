# Stage 1: Build the application
FROM python:3.9@sha256:089307feed90d56945980075a2a857c28141354a0158c5a251ebf63291859aa6 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:657a140aae5f8eb61c69c3df950fade52f1a7924f88612071acccb863a9efe0f

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

# Stage 1: Build the application
FROM python:3.9@sha256:d05169bc6332f6ec7686be45843c8fa66a1e2e76b28d0d3b5fa6ac7c9ff2cb6d AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:1e3437daae1d9cebce372794eacfac254dd108200e47c8b7f56a633ebd3e2a0a

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

# Stage 1: Build the application
FROM python:3.9@sha256:3b199ecfbdb57cf390ef4af18d3c0ea630ade330c5b1eaf7aa37971ce304cc03 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:e6941b744e8eb9df6cf6baf323d2b9ad1dfe17d118f5efee14634aff4d47c76f

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

# Stage 1: Build the application
FROM python:3.9@sha256:e298e2e898691a938073f670dac8ef1a551c83344b67b5d8e32d1fbc8e0b57f8 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:d3185e5aa645a4ff0b52416af05c8465d93791e49c5a0d0f565c119099f26cde

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

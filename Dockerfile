# Stage 1: Build the application
FROM python:3.9@sha256:fe42785983466dca3720efae1c5fd6b048aec792aee313abfc5c1568b321f944 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:186afb5d1779c8b5751efd1e79d0e17df428f1e53c8a97390211d47f1b9d2ec4

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

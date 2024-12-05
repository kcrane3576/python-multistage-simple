# Stage 1: Build the application
FROM python:3.9@sha256:ef79f8314118b7cde6910d35f4166c902e7f87f47086686256556b97d991a0fb AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:5772df931ea2bad11e17170ce221f86c751c91eaa537733f069e20bbbb8e9fa7

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

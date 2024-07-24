# Stage 1: Build the application
FROM python:3.9@sha256:3a6ca14431e149dc3d41e61d5b23c01d9ca067d49ad3b24eed691a0aa5d923ec AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:3e51ce4f15b1f62a6f348dd0be1e133745633da5e9707f19eef54373bd87c16b

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

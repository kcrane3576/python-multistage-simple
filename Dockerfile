# Stage 1: Build the application
FROM python:3.9@sha256:27229a233a5e4fae8c76edb8f9d54f54c822a58e5973702696cb4671dd483703 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:54fb3e4ad3a04e2c74702a8016cb4c1945dc6a0b5ea775c801720b58c9c38677

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

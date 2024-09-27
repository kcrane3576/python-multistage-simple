# Stage 1: Build the application
FROM python:3.9@sha256:a361156545d2a51ad71c5abe92189d85bb551ace735e1f28389cf4ad8585a36c AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:e65183e4ee98ed10d0732e20275acd768ada3eac1fdc194cdc0d04d9457daed7

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

# Stage 1: Build the application
FROM python:3.9@sha256:2992c6545e18c184feca5a2aa3a086b2cae0475b7a61f7199723ca5690882a2d AS builder

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

# Stage 1: Build the application
FROM python:3.9@sha256:5d635c0e6088939196d243de1b3b3c507072dde6020a1337cb0c533ddd93a57d AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:54b1eb6dee478a3105c78fecfe75d796963537b76cc6fb7fffd54d2f70695543

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

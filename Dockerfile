# Stage 1: Build the application
FROM python:3.9@sha256:30f99c4f10097ec944f314bd02a4ffb04a5bf9380dd67695dfb4bfd2ebaf803f AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:6a8fad40d6171de2c3cdaf6d525a004baa7781483870c3542d22fc5395cbba58

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

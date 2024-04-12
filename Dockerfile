# Stage 1: Build the application
FROM python:3.9@sha256:c39e7db7ea07b57e384f4a70c08377a1af4404ec5dff514a973d9042714874bd AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:aade58da89dabdac159ba0e5ca98d9fa665c17d194f977e5b95994005edbf37b

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

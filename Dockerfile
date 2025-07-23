# Stage 1: Build the application
FROM python:3.9@sha256:8445f8b2ed3fa66bf9f244fad44657dff3fc7021a9ae105734973c8dc014e8df AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:612a34b7ca7dd49e4c1bd8d83d5af65def0c4e67256ab6c597ea6fb6716215c7

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

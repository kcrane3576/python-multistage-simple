# Stage 1: Build the application
FROM python:3.9@sha256:145dfd1245cd3809265c458b86f9075ac4ff5001200d6edd012a3664d8c141e1 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:7804959ca512a767515468c5952dcacb44e1dd7cfc114eb0eb58080aef736561

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

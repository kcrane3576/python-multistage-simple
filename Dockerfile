# Stage 1: Build the application
FROM python:3.9@sha256:99558c563f080fd3c0f84b0f37215802938d5d38109ed305722a245963196870 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:e9cbb5c76feebc0d058e561eadb168cdcfe3b376b674917ea44858e4f4acedee

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

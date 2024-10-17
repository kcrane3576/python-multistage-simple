# Stage 1: Build the application
FROM python:3.9@sha256:c808b28216a039aeaa6152a50ed129d0321867da16f6c93bd26e4973355902d2 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:5043a282c3a6fbe5e34fc298ef9ed40fe23341969219bc2e9c36ccaf25bf7369

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

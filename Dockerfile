# Stage 1: Build the application
FROM python:3.9@sha256:da77ddda21ce9e69800a9e25f5b5f8d2db7f8aeab740782039dae7084c896894 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:693904090d8bc26d16ca554c1dfb56b8afb37947e729844f2eebaab390ed98a5

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

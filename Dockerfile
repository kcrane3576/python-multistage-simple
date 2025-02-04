# Stage 1: Build the application
FROM python:3.9@sha256:3493922743fd230ae8db091c94c799c618bf1506568adfa3a8eb32833b07cbb9 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:fac22322fdb10b597b94a317f8a97ea9f2295008b95ae2e32856f302d70fda1c

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

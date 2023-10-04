# Stage 1: Build the application
FROM python:3.9@sha256:1fcc3e2d0128c39c20eb34e1a094c66f78cbea1de52428e0a5a82588bf0d50c7 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:08a6a1666ddebe94becbec1986235cb8c321d2f7a7fd00f614befba5c1f23e67

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

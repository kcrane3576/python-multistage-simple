# Stage 1: Build the application
FROM python:3.9@sha256:138aa19c57c4ac5ecc23ed8bb5c40d4944bf8c9848687518e2695b73e9ce1672 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:e05be7fa5b887748df8b7ee9ee26201b4c20cf741cccae0393ee744c0b185401

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

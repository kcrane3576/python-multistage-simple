# Stage 1: Build the application
FROM python:3.9@sha256:9edfcfbe4d1bc6aabe0dd49a0e9cf625d83524edf574bc8cca7b1214bd9d170e AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:12dca0d1b0dbbc74a48c0d9a49762f776e2ceb910b8e0c0f752de45b18209fe6

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

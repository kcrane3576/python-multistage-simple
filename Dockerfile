# Stage 1: Build the application
FROM python:3.9@sha256:4c48c04d1fb3009c52c336e056f902701a669fb1a0dcf7b31eecaa5902e4b624 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:b92e6f45b58d9cafacc38563e946f8d249d850db862cbbd8befcf7f49eef8209

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

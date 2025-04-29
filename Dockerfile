# Stage 1: Build the application
FROM python:3.9@sha256:69d9093e54e4fc34f1979e4e7a61f681bc91d61eb7d6689bc9e92a3228dbe123 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:664d39a4bed04d860d2cc51e5c563d8b20ec0740eb3e28de223058fab94a6fc9

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

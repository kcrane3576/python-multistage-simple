# Stage 1: Build the application
FROM python:3.9@sha256:96daeb1dce644e6dd313489b27a83fbd6d1ccd81d6993e8079f78e4485ba24f7 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:990eb8f30571e0aaabfa1a7deb9fe2f6c1d4163a389004fbf823db6fee7c3642

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

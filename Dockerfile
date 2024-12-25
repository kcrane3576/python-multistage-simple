# Stage 1: Build the application
FROM python:3.9@sha256:dd8b65c39a729f946398d2e03a3e6defc8c0cfec409b9f536200634ad6408b54 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:1b245955d2353cfb418c0c3dab1e2520943d253db53278c5364c121f9de7b83c

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

# Stage 1: Build the application
FROM python:3.9@sha256:95879505685f0743e7656e1b06fdc3c6308ed12485a039af82fe14099b5042a9 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:4c70407660b9399e0e4d05ba57fc3aca7460610e6f80f955776f825e39b856ce

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

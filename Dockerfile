# Stage 1: Build the application
FROM python:3.9@sha256:530d4ba717be787c0e2d011aa107edac6d721f8c06fe6d44708d4aa5e9bc5ec9 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:51c781cd11dd1f2a95e2bef833a5920042743fa502d66c9e12c1a841d983f9a7

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

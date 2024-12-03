# Stage 1: Build the application
FROM python:3.9@sha256:1e7597c5d230e17dc74178bedd3553a817ec5d9b142ef3bdbc8b075997aaaa02 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:5772df931ea2bad11e17170ce221f86c751c91eaa537733f069e20bbbb8e9fa7

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

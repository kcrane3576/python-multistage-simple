# Stage 1: Build the application
FROM python:3.9@sha256:b7a5b88f353318640d8df561bcfb96c6249978aea73aaa79de2f23de305a64d8 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:2f2dd1274c5ca3552413663c04d345f2a99bbe35abde5c2308e281d7fc01d859

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

# Stage 1: Build the application
FROM python:3.9@sha256:a253f73a16a5bdcd1a92b35faed036d3d5a6ab45caddccb6b7dea8f7e509db1e

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:a253f73a16a5bdcd1a92b35faed036d3d5a6ab45caddccb6b7dea8f7e509db1e

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

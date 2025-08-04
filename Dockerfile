# Stage 1: Build the application
FROM python:3.9@sha256:754dbbaf5fe730bb2460efb3300293c62c222f74fbf8534ed23691c617c9609b AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:4b826e2ca2191c24a03bdbf0c342a73c6ee4ce929eac5ebc47fef78f66b839d6

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

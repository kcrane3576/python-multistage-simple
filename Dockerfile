# Stage 1: Build the application
FROM python:3.9@sha256:fcbb280be692687a728280ac9dd71ecd84cbcb88ec11da9f042d3bf637f8448d AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:369a16fc95ce13e4e1e1c76a5eaa88bd16e955dc82a55c2a69c3c25bb61dd590

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

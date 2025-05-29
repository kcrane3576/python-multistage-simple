# Stage 1: Build the application
FROM python:3.9@sha256:6021c6c9624cb975a2b80710f54f4afd19939a2e1da820fcec995b6ca3be9b0b AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:aff2066ec8914f7383e115bbbcde4d24da428eac377b0d4bb73806de992d240f

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

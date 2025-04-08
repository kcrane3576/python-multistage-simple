# Stage 1: Build the application
FROM python:3.9@sha256:5d489923f907e0d2a95cda5451011aba8c51aa8d497513320172fb41790686aa AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:add145df616d30be736bb2b101035287722fbf72524f5fbce98bd0b5b711d030

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

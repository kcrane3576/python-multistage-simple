# Stage 1: Build the application
FROM python:3.9@sha256:5be6ab129779da4729eb8be146bdddc3662b7c7b6cc7a07e9f5a675cdb4746c7 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:69e712dbe4c4a166527cbf69374533125cfb6ee93a5e39031a0191c741d386d7

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

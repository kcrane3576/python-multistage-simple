# Stage 1: Build the application
FROM python:3.9@sha256:fea84f3a3b72c41efe7fc3b07ae209c6856b852b942c05fa88b747b74f70e711 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:af25db738bc74a340e43b9034a11b96ba85c4c0d6de0f03cdba2758257b08e0a

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

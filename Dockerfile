# Stage 1: Build the application
FROM python:3.9@sha256:867384a693c7e2acee72fc6d9cb93792b5959a3f01b930bc2d5191b1a32825be AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:1a2de106dc8e6a92151bac114a76dd2e8878b48615938b9b78cebb15cc06b1ce

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

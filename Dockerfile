# Stage 1: Build the application
FROM python:3.9@sha256:557bd877cebc90f21c73e73ee52d3e77efac44c09a54f5764bba137747523da9 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:2d01c76bb5bdcee5e711df349ff6e76efdf920f2e30e50effcf4f6e0dfccd3a2

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

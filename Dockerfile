# Stage 1: Build the application
FROM python:3.9@sha256:1ab70c106669b2bc6d94518d59814c6de98e0477618435267d848dc5fb5f9dbb AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:79d902e3c05bb26b70c5bdf4942e7e6383b927e29d91349eca306a433ae41050

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

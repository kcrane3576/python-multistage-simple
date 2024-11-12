# Stage 1: Build the application
FROM python:3.9@sha256:94854ad6073bcd97529a10e3f1106fa7e87565889d28262725f23af1ca2d06c8 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:9c88d5ac89fc0186340d9b677fed60f9672f4764fdab2ad7b11274fcedb5ffde

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

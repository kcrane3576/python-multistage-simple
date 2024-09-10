# Stage 1: Build the application
FROM python:3.9@sha256:dbb0be5b67aa84b9e3e4f325c7844ab439f40a5cca717c5b24e671cfb41dbb46 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:c18e51b98c645198ed42066a61807aa22c66d66e913446fb306519f25ccebb2c

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

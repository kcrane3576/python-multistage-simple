# Stage 1: Build the application
FROM python:3.9@sha256:d034d00c77e916573c3e8a6c1ed713a8f111f850045ffc9e78dcb14cf5ff0eb2 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:7077756788204b53b1723035c82a05f37a03dfd94f6ee028b50124ed30790826

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

# Stage 1: Build the application
FROM python:3.9@sha256:fd648a271c795a281971789a1f731d284148c8d88fcd21f78f52130e0c9cf5a3 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:5cf696ff9a72fd777c63052cba94defe6c548e501e748465e57e0b18f3a9779e

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

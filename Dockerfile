# Stage 1: Build the application
FROM python:3.9@sha256:ddf3e328f78494805eeb0c43b6754178a941ae93b26949e493368af633c9c8a2 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:590aa200bf472f2b15eb5b72bbe20410ddeee30c79c2c306c1c83ee315cd1efb

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

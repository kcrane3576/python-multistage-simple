# Stage 1: Build the application
FROM python:3.9@sha256:fc6b1f331fbf834dded7ffe36ca35f4f9dadbe665a00821f3c4af152a3332f13 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:c77f33ea7561185b45f8afa0ade846585ac3ae87e0f814948f8232a974d584de

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

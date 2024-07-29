# Stage 1: Build the application
FROM python:3.9@sha256:70dce00379744edb10d8c7ee8339bbf964dcbcadc1da862bdc59dc746513c04c AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:27211e8bbfd2c91ac9adbde0565b9ac18234bfcde8ef0e6a3404fd404f26ea13

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

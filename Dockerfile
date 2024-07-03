# Stage 1: Build the application
FROM python:3.9@sha256:1f887936a6bbb8a3394d9beeba6681328c82978374d713aa498cd8a4a5ef26ef AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:4c7c47da2df1d0efb7d14812a37c42bc5f2ef3fea9b92bf07a39940945a67498

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

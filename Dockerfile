# Stage 1: Build the application
FROM python:3.9@sha256:0507144d70932768840309fb2c831be1b6db228859fabe0b2c2085310607811f AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:40007fe18a72a2e7166be350d52dab86b9fe18f2de08e6a38e26422fb247e81e

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

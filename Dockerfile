# Stage 1: Build the application
FROM python:3.9@sha256:753586e289a94965eb389ae5397233d32c3cff0f40f81c633dcc00d277012634 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:4a40348ea426c5d657b710344c78ed073f3331d8631c14fbee393a94406b5469

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

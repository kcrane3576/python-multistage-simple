# Stage 1: Build the application
FROM python:3.9@sha256:2992dbc3626ab64f34207d4125203a8977047e0b214e9588349b45f5c1bea61a AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:68a2336b5d5e94d1f2d411f914ab80be75c54147c547cab31222df2bd398f8df

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

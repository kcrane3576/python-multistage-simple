# Stage 1: Build the application
FROM python:3.9@sha256:484fa05670e6263039afba256b7e7dc890b37dc19b400176c208ce13de3cfd86 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:5fa679d492e5cb06ce42ddbfb02609291f80f3288b799f6bc2b752a8b51268fc

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

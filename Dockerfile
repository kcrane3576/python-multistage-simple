# Stage 1: Build the application
FROM python:3.9@sha256:0596c508fdfdf28fd3b98e170f7e3d4708d01df6e6d4bffa981fd6dd22dbd1a5 AS

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:0596c508fdfdf28fd3b98e170f7e3d4708d01df6e6d4bffa981fd6dd22dbd1a5

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

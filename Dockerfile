# Stage 1: Build the application
FROM python:3.9@sha256:e3ad310293463b7529cfc610715b38cc18ba6871ea28839a06898a65500b9085 AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:3cc492bb6091b5b7b47910933b026663fa75da9c607bfd596c8bec7dd8852e97

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

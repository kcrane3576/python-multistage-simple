# Stage 1: Build the application
FROM python:3.9@sha256:098eb0506bfc6e32f8d9221a5117484b403aac48008166f148bdf84b8db4be7e AS builder

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM python:3.9-slim@sha256:86dc283655293ea4037215ace6d1e3ed04cd57f04342a473915bc3c177f2fb86

WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Expose the port your application runs on (if applicable)
EXPOSE 8000

# Command to start the application
CMD ["python", "app.py"]

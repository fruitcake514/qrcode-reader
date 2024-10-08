# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install required system libraries
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    libgl1-mesa-glx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Clone the GitHub repository
RUN git clone https://github.com/<your-username>/<your-repo>.git /app

# Set the working directory in the container
WORKDIR /app

# Install any necessary Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Flask is running on
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]

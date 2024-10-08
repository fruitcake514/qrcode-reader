# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install required system libraries
RUN apt update && \
    apt install -y --no-install-recommends \
    git \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libatlas-base-dev \
    libjpeg-dev \
    libtbbmalloc2 \
    libtiff5-dev \
    libgtk-3-dev \
    libzbar-dev && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Clone the GitHub repository
RUN git clone https://github.com/fruitcake514/qrcode-reader.git /app

# Set the working directory in the container
WORKDIR /app

# Install any necessary Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Flask is running on
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]

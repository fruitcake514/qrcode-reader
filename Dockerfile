# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install git so we can clone the repository
RUN apt-get update && apt-get install -y git

# Clone the GitHub repository
RUN git clone https://github.com/fruitcake514/qrcode-reader.git /app

# Set the working directory in the container
WORKDIR /app

# Install any necessary dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Flask is running on
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]

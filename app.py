from flask import Flask, render_template, request, redirect, url_for
import cv2
from pyzbar.pyzbar import decode
from PIL import Image
import os

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['ALLOWED_EXTENSIONS'] = {'png', 'jpg', 'jpeg', 'gif'}

# Check if file has a valid extension
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

# Route for the homepage
@app.route('/')
def index():
    return render_template('index.html')

# Route for uploading image and extracting QR code data
@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return 'No file part'
    file = request.files['file']
    if file.filename == '':
        return 'No selected file'
    if file and allowed_file(file.filename):
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
        file.save(filepath)

        # Extract QR code data
        data = extract_qr_code_data(filepath)
        return f"QR Code Data: {data}"

    return 'Invalid file format'

# Function to decode the QR code from an image
def extract_qr_code_data(image_path):
    img = cv2.imread(image_path)
    decoded_objects = decode(img)

    if decoded_objects:
        qr_data = decoded_objects[0].data.decode('utf-8')
        return qr_data
    else:
        return 'No QR code found'

if __name__ == '__main__':
    if not os.path.exists('uploads'):
        os.makedirs('uploads')
    app.run(debug=True)

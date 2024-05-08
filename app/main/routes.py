from flask import jsonify, request

import app.main.modules.objects_detection as od
from app.main import bp


@bp.route('/detect', methods=['POST'])
def detect():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400

    detections = od.detect(file)
    return jsonify(detections)

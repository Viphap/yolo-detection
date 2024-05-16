from flask import jsonify, request, send_file

import app.main.modules.objects_detection as od
import app.main.modules.stream as stream
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

@bp.route('/stream/<filename>', methods=['GET'])
def stream(filename):
    return send_file(f'/home/truongpx/repos/viphap/yolo-server/videos/u/v/I4jcU51Mh5/{filename}')

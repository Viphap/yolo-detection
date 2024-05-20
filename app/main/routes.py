from flask import  abort, jsonify, request, send_file

import app.main.modules.objects_detection as od
import app.main.modules.stream as s
from app.main import bp


@bp.route('/detect', methods=['POST'])
def detect():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400

    stream_ke = request.args.get('ke')
    stream_id = request.args.get('id')
    stream_fps = request.args.get('fps')
    s.create_stream(stream_ke, stream_id, stream_fps)

    detections, raw_result = od.detect(file)
    s.process_frame(
        stream_id,
        file,
        raw_result['boxes'], raw_result['scores'], raw_result['class_ids']
    )

    # detections = []
    # s.test_process_frame(stream_id, file)

    return jsonify(detections)


@bp.route('/stream/<ke>/<id>/<file_name>', methods=['GET'])
def stream(ke, id, file_name):
    stream_path = s.get_stream_path(id, file_name)
    if not stream_path:
        return abort(404)
    return send_file(stream_path)

import numpy as np
from PIL import Image

from app.yolo.utils import CLASS_NAMES
from app.yolo.YOLO import YOLO


yolo_detector = YOLO(conf_thres=0.2, iou_thres=0.3)

def detect(file):
    image = Image.open(file.stream).convert('RGB')
    image = np.array(image)

    boxes, scores, class_ids = yolo_detector(image)

    detections = []
    raw_result = {
        'boxes': boxes,
        'scores': scores,
        'class_ids': class_ids
    }

    for i in range(len(boxes)):
        detections.append({
            'tag': f'{CLASS_NAMES[class_ids[i]]} {str(round(scores[i], 2))}',
            'confidence': float(scores[i]),
            'x': float(boxes[i][0]),
            'y': float(boxes[i][1]),
            'width': float(boxes[i][2] - boxes[i][0]),
            'height': float(boxes[i][3] - boxes[i][1]),
        })

    return detections, raw_result

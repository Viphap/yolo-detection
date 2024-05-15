import numpy as np
from PIL import Image

from app.yolov8.utils import CLASS_NAMES
from app.yolov8.YOLOv8 import YOLOv8

model_path = 'app/yolov8/models/model.onnx'
yolov8_detector = YOLOv8(model_path, conf_thres=0.2, iou_thres=0.3)

def detect(file):
    image = Image.open(file.stream).convert('RGB')
    image = np.array(image)

    boxes, scores, class_ids = yolov8_detector(image)

    detections = []
    for i in range(len(boxes)):
        detections.append({
            'tag': f'{CLASS_NAMES[class_ids[i]]} {str(round(scores[i], 2))}',
            'confidence': float(scores[i]),
            'x': float(boxes[i][0]),
            'y': float(boxes[i][1]),
            'width': float(boxes[i][2] - boxes[i][0]),
            'height': float(boxes[i][3] - boxes[i][1]),
        })

    return detections

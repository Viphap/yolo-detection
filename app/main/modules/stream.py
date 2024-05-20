import os

import numpy as np
from PIL import Image

from app.stream.StreamsList import StreamsList
from app.stream.utils import create_dir_ine
from config import basedir


create_dir_ine(os.path.join(basedir, 'videos'))
streams_list = StreamsList()


def create_stream(ke, id, fps):
    streams_list.create_stream(ke, id, fps)


def process_frame(id, file, boxes, scores, class_ids):
    stream = streams_list.get_stream(id)
    image = Image.open(file.stream).convert('RGB')
    image = np.array(image)
    stream.process_frame(image, boxes, scores, class_ids)


def test_process_frame(id, file):
    stream = streams_list.get_stream(id)
    image = Image.open(file.stream).convert('RGB')
    image = np.array(image)
    stream.test_process_frame(image)


def get_stream_path(id, file_name):
    stream = streams_list.get_stream(id)
    if not stream:
        return None
    return stream.get_stream_path(file_name)

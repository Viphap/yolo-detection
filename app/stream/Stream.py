import os
import shutil
import subprocess

from app.yolo.utils import draw_detections
from config import basedir


class Stream:

    def __init__(self, ke, id, fps):
        self.ke = ke
        self.id = id
        self.fps = fps
        self.dir_path = os.path.join(basedir, f'videos/{self.ke}/{self.id}')

        self.create_stream_dir()
        self.build_ffmpeg_process()


    def create_stream_dir(self):
        if not os.path.exists(self.dir_path):
            os.makedirs(self.dir_path)
        else:
            print('Stream dir has already existed')


    def build_ffmpeg_process(self):
        hls_output = os.path.join(self.dir_path, 's.m3u8')
        segment_pattern = self.dir_path + '/s%d.ts'

        ffmpeg_command = [
            'ffmpeg',
            '-y', # overwrite output files
            '-f', 'rawvideo',
            '-pix_fmt', 'bgr24',
            '-s', '640x480', # frame size
            '-r', self.fps,
            '-i', '-',
            '-c:v', 'libx264',
            '-g', '1',
            '-f', 'hls',
            '-hls_list_size', '5',
            '-start_number', '0',
            '-hls_time', '5',
            '-hls_segment_filename', segment_pattern,
            '-hls_flags', '+delete_segments+omit_endlist+discont_start',
            hls_output
        ]

        self.process = subprocess.Popen(ffmpeg_command, stdin=subprocess.PIPE)


    def update_fps(self, fps):
        self.fps = fps
        self.drop_stream_process()
        self.build_ffmpeg_process()


    def drop_stream(self):
        self.drop_stream_process()
        self.delete_stream_dir()


    def drop_stream_process(self):
        self.process.stdin.close()
        self.process.stderr.close()
        self.process.wait()


    def delete_stream_dir(self):
        if os.path.exists(self.dir_path):
            shutil.rmtree(self.dir_path)


    def process_frame(self, image, boxes, scores, class_ids):
        d_image = draw_detections(image, boxes, scores, class_ids)
        self.process.stdin.write(d_image.tobytes())


    def test_process_frame(self, image):
        self.process.stdin.write(image.tobytes())


    def get_stream_path(self, file_name):
        return os.path.join(self.dir_path, file_name)

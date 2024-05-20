import os


def create_dir_ine(path):
    if not os.path.exists(path):
        os.makedirs(path)

#!/bin/bash

ROOT_DIR=$(dirname $0)

echo "Downloading YoloV8m model..."
MODELS_DIR=$ROOT_DIR/app/yolov8/models
# Check if the folder exists
if [ ! -d "$MODELS_DIR"]; then
    mkdir "$MODELS_DIR"
fi
wget -P "$MODELS_DIR" -O "model.onnx" "https://github.com/xuantruongpham/yolov8-server/releases/download/resources/yolov8l.onnx"

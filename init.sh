#!/bin/bash

ROOT_DIR=$(dirname $0)

echo "Downloading Yolo $MODEL model..."
MODELS_DIR=$ROOT_DIR/app/yolo/models
# Check if the folder exists
if [ ! -d "$MODELS_DIR"]; then
    mkdir "$MODELS_DIR"
fi
wget -P "$MODELS_DIR" -O "https://github.com/xuantruongpham/yolo-server/releases/download/resources/$MODEL.onnx"

#!/bin/bash

CUR_DIR=$(pwd)

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: $0 <model_name> [save_path]"
    exit 1
fi

model_name=$1
save_path=${2:-"./models"}

echo $model_name
echo $save_path

if [ ! -d "$save_path" ]; then
    mkdir -p "$save_path"
fi

wget -P "$save_path" "https://github.com/xuantruongpham/yolo-server/releases/download/resources/$model_name.onnx"

if [ $? -eq 0 ]; then
    echo "$model_name model downloaded successfully"
else
    echo "Failed to download $model_name model"
    exit 1
fi

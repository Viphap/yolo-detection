#!/bin/sh
echo "------------------------------------------"
echo "-- Installing CUDA Toolkit and CUDA DNN --"
echo "------------------------------------------"
# Install CUDA Drivers and Toolkit
if [ -x "$(command -v apt)" ]; then
    # Driver
    echo "Installing nvidia-driver-550"
    sudo apt-get update
    sudo apt-get install -y nvidia-driver-550-open
    sudo apt-get install -y cuda-drivers-550

    # CUDA
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
    sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
    echo "Downloading CUDA..."
    wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-ubuntu2004-11-8-local_11.8.0-520.61.05-1_amd64.deb
    sudo cp /var/cuda-repo-ubuntu2004-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
    sudo dpkg -i cuda-repo-ubuntu2004-11-8-local_11.8.0-520.61.05-1_amd64.deb
    sudo apt-get update
    sudo apt-get install -y cuda-11-8
    sudo apt-get install -y cuda-toolkit-11-8

    # CUDA DNN
    echo "Installing cudnn..."
    wget https://github.com/xuantruongpham/yolov8-server/releases/download/resources/cudnn-local-repo-ubuntu2004-8.9.2.26_1.0-1_amd64.deb
    sudo cp /var/cudnn-local-repo-ubuntu2004-8.9.2.26/cudnn-*-keyring.gpg /usr/share/keyrings/
    sudo dpkg -i cudnn-local-repo-ubuntu2004-8.9.2.26_1.0-1_amd64.deb
    sudo apt-get update
    sudo apt-get -y install cudnn-cuda-11

    export PATH=/usr/local/cuda-11.8/bin:$PATH
    export PATH=/usr/local/cuda-11.8/targets/x86_64-linux/lib:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib64:$LD_LIBRARY_PATH

    # Cleanup
    echo "-- Cleaning Up --"
    sudo rm -f cuda-repo-ubuntu2004-11-8-local_11.8.0-520.61.05-1_amd64.deb
    sudo rm -f cudnn-local-repo-ubuntu2004-8.9.2.26_1.0-1_amd64.deb
fi

echo "------------------------------"
echo "Reboot is required. Do it now?"
echo "------------------------------"
echo "(y)es or (N)o. Default is No."
read rebootTheMachineHomie
if [ "$rebootTheMachineHomie" = "y" ] || [ "$rebootTheMachineHomie" = "Y" ]; then
    sudo reboot
fi

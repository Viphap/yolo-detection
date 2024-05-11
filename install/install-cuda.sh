#!/bin/sh
echo "------------------------------------------"
echo "-- Installing CUDA Toolkit and CUDA DNN --"
echo "------------------------------------------"
# Install CUDA Drivers and Toolkit
if [ -x "$(command -v apt)" ]; then
    # CUDA Toolkit
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
    sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
    echo "Downloading CUDA Toolkit..."
    wget https://developer.download.nvidia.com/compute/cuda/12.4.1/local_installers/cuda-repo-ubuntu2004-12-4-local_12.4.1-550.54.15-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu2004-12-4-local_12.4.1-550.54.15-1_amd64.deb   
    sudo cp /var/cuda-repo-ubuntu2004-12-4-local/cuda-*-keyring.gpg /usr/share/keyrings/
    sudo apt-get update
    sudo apt-get -y install cuda-12-4
    sudo apt-get -y install cuda-toolkit-12-4

    # Driver
    echo "Installing nvidia-driver-550"
    sudo apt-get install -y nvidia-driver-550-open
    sudo apt-get install -y cuda-drivers-550

    # Install CUDA DNN
    echo "Installing cudnn-cuda-12"
    wget https://developer.download.nvidia.com/compute/cudnn/9.1.1/local_installers/cudnn-local-repo-ubuntu2004-9.1.1_1.0-1_amd64.deb
    sudo dpkg -i cudnn-local-repo-ubuntu2004-9.1.1_1.0-1_amd64.deb
    sudo cp /var/cudnn-local-repo-ubuntu2004-9.1.1/cudnn-*-keyring.gpg /usr/share/keyrings/
    sudo apt-get update
    sudo apt-get -y install cudnn-cuda-12

    export PATH=/usr/local/cuda-12.4/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda-12.4/lib64:$LD_LIBRARY_PATH

    # Cleanup
    echo "-- Cleaning Up --"
    sudo rm -f cuda-repo-ubuntu2004-12-4-local_12.4.1-550.54.15-1_amd64.deb
    sudo rm -f cudnn-local-repo-ubuntu2004-9.1.1_1.0-1_amd64.deb
fi

echo "------------------------------"
echo "Reboot is required. Do it now?"
echo "------------------------------"
echo "(y)es or (N)o. Default is No."
read rebootTheMachineHomie
if [ "$rebootTheMachineHomie" = "y" ] || [ "$rebootTheMachineHomie" = "Y" ]; then
    sudo reboot
fi

#!/bin/sh
echo "------------------------------------------"
echo "-- Installing CUDA Toolkit and CUDA DNN --"
echo "------------------------------------------"
# Install CUDA Drivers and Toolkit
if [ -x "$(command -v apt)" ]; then
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
    wget https://github.com/xuantruongpham/yolo-server/releases/download/resources/cudnn-local-repo-ubuntu2004-8.9.2.26_1.0-1_amd64.deb
    sudo cp /var/cudnn-local-repo-ubuntu2004-8.9.2.26/cudnn-*-keyring.gpg /usr/share/keyrings/
    sudo dpkg -i cudnn-local-repo-ubuntu2004-8.9.2.26_1.0-1_amd64.deb
    sudo apt-get update
    sudo apt-get -y install cudnn-cuda-11

    echo 'export PATH=/usr/local/cuda-11.8/bin:$PATH' >> ~/.bash_profile
    echo 'export PATH=/usr/local/cuda-11.8/targets/x86_64-linux/lib:$PATH' >> ~/.bash_profile
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib64:$LD_LIBRARY_PATH' >> ~/.bash_profile

    # Cleanup
    echo "-- Cleaning Up --"
    sudo rm -f cuda-repo-ubuntu2004-11-8-local_11.8.0-520.61.05-1_amd64.deb
    sudo rm -f cudnn-local-repo-ubuntu2004-8.9.2.26_1.0-1_amd64.deb

elif [ -x "$(command -v yum)" ]; then
    sudo yum update
    sudo yum install -y wget

    # CUDA
    echo "Downloading CUDA..."
    wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-rhel7-11-8-local-11.8.0_520.61.05-1.x86_64.rpm
    sudo rpm -i cuda-repo-rhel7-11-8-local-11.8.0_520.61.05-1.x86_64.rpm
    sudo yum clean all
    sudo yum install -y nvidia-driver-latest-dkms
    sudo yum install -y cuda-11-8
    sudo yum install -y cuda-toolkit-11-8

    # CUDA DNN
    echo "Installing cudnn..."
    wget https://github.com/xuantruongpham/yolo-server/releases/download/resources/cudnn-local-repo-rhel7-8.9.2.26-1.0-1.x86_64.rpm
    sudo rpm -i cudnn-local-repo-rhel7-8.9.2.26-1.0-1.x86_64.rpm
    sudo yum clean all
    sudo yum -y install cudnn-cuda-11

    echo 'export PATH=/usr/local/cuda-11.8/bin:$PATH' >> ~/.bash_profile
    echo 'export PATH=/usr/local/cuda-11.8/targets/x86_64-linux/lib:$PATH' >> ~/.bash_profile
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib64:$LD_LIBRARY_PATH' >> ~/.bash_profile

    # Cleanup
    echo "-- Cleaning Up --"
    sudo rm -f cuda-repo-rhel7-11-8-local-11.8.0_520.61.05-1.x86_64.rpm
    sudo rm -f cudnn-local-repo-rhel8-9.1.1-1.0-1.x86_64.rpm
fi

echo "------------------------------"
echo "Reboot is required. Do it now?"
echo "------------------------------"
echo "(y)es or (N)o. Default is No."
read rebootTheMachineHomie
if [ "$rebootTheMachineHomie" = "y" ] || [ "$rebootTheMachineHomie" = "Y" ]; then
    sudo reboot
fi

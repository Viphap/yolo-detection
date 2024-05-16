# Yolo Server

## Installation

> Tested on Ubuntu 20.04 and CentOS 7

### Install Docker for Nvidia

Use this doc: [https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

### Install NVIDIA drivers

Download run file from [https://nvidia.com/download/index.aspx?lang=en-us](https://nvidia.com/download/index.aspx?lang=en-us).

#### On CentOS

Use this doc [https://docs.heavy.ai/installation-and-configuration/installation/installing-on-centos/centos-yum-gpu-os](https://docs.heavy.ai/installation-and-configuration/installation/installing-on-centos/centos-yum-gpu-os) for install drivers.

### Install CUDA

```bash
sudo bash ./install/install-cuda.sh
```

### Run docker

```bash
docker compose up -d
```

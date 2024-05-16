FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

RUN apt-get update -y && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install software-properties-common -y
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get install -y python3.10
RUN apt-get install -y \
    curl \
    wget \
    libgl1-mesa-dev \
    libglib2.0-0 \
    zlib1g

RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
RUN ln -fs /usr/bin/python3.10 /usr/bin/python

ARG WORKDIR=/home/app
WORKDIR /home/app
COPY . ./

RUN pip3.10 install --upgrade setuptools
RUN pip3.10 install -r requirements.txt

EXPOSE 5000

CMD [ "python3.10", "-m", "flask", "run", "--host", "0.0.0.0", "--port", "5000" ]

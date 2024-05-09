FROM python:3.12.3-slim

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y \
        wget \
        libgl1-mesa-dev \
        libglib2.0-0

ARG WORKDIR=/home/app
WORKDIR /home/app
COPY . ./

RUN pip install -r requirements.txt

RUN sh ${WORKDIR}/init.sh

EXPOSE 5000

CMD [ "flask", "run", "--host", "0.0.0.0", "--port", "5000" ]

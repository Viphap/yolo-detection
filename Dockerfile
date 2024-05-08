FROM python:3.12.3

ARG WORKDIR=/home/app
WORKDIR /home/app
COPY . ./

RUN pip install -r requirements.txt

RUN sh ${WORKDIR}/init.sh

EXPOSE 5000

CMD [ "flask", "run" ]

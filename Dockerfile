FROM registry.access.redhat.com/ubi8/ubi

MAINTAINER IKEA Solutions "ikeasol@asml.com"

RUN dnf install -y nginx python38 python38-devel gcc

COPY  ./flask_app/* /flask_app/

EXPOSE 80

RUN useradd appuser

WORKDIR /flask_app

RUN pip3 install -r /flask_app/requirements.txt --src /usr/local/src

COPY ./conf/nginx.conf /etc/nginx

RUN chmod +x ./start.sh

CMD [ "./start.sh" ]

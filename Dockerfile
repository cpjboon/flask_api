FROM registry.access.redhat.com/ubi8/ubi

MAINTAINER IKEA Solutions "ikeasol@asml.com"

LABEL io.k8s.description="A basic NGINX server with uWSGI" \
io.k8s.display-name="NGINX HTTP Server with uWSGI" \
io.openshift.expose-services="80:http" \
io.openshift.tags="flask, uWSGI"

RUN dnf install -y nginx python38 python38-devel gcc

COPY  ./flask_app/* /flask_app/

EXPOSE 80

RUN useradd appuser

WORKDIR /flask_app

RUN pip3 install -r /flask_app/requirements.txt --src /usr/local/src

COPY ./conf/nginx.conf /etc/nginx

RUN chmod +x ./start.sh

CMD [ "./start.sh" ]

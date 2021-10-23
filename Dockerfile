FROM registry.access.redhat.com/ubi8/ubi

MAINTAINER IKEA Solutions "ikeasol@asml.com"

LABEL io.k8s.description="A basic NGINX server with uWSGI" \
io.k8s.display-name="NGINX HTTP Server with uWSGI" \
io.openshift.expose-services="8080:http" \
io.openshift.tags="flask, uWSGI"

RUN dnf install -y nginx python38 python38-devel gcc

COPY  ./flask_app/* /flask_app/ 
COPY ./conf/nginx.conf /etc/nginx

EXPOSE 8080

RUN useradd appuser && \
    mkdir /var/run/nginx && \
    mkdir -p /var/www/html

RUN chgrp -R 0 /var/log/nginx /var/run/nginx /var/www/html && \
chmod -R g=u /var/log/nginx /var/run/nginx /var/www/html

WORKDIR /flask_app

RUN chmod +x ./start.sh

USER appuser

RUN pip3 install -r /flask_app/requirements.txt --src /usr/local/src

CMD [ "./start.sh" ]

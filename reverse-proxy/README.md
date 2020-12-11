# Nginx Front End Setup

Basic nginx front end reverse proxy that connects to docker containers 
that host websites.

Docker compose creates an image for nginx

Notice that the image name is the concatenation of the foldername, chaosopher.com, and the service name reverse. 

## Dev SSL Certificate

$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./rp/config.d/certs.d/nginx-selfsigned.key -out ./rp/config.d/certs.d/nginx-selfsigned.crt
$ sudo openssl dhparam -out ./rp/config.d/certs.d/dhparam.pem 2048

## Starting

We need a custom image, so lets build a new docker image.

$ docker-compose build

Test the image

$ docker-compose up


## Installing Registry

## Pushing to Registry

$ docker image tag chaosophercom_reverse:latest chaosopher.com:5000/chaosophercom_reverse

$ docker push chaosopher.com:5000/chaosophercom_reverse

## Cleaning Up

$ docker container rm -v chaosopher.com_reverse
$ docker image rm nginx

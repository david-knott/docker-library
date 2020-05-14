Basic lamp setup with 2 apache backends and one nginx front end.

## Dev SSL Certificate

$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./rp/config.d/certs.d/nginx-selfsigned.key -out ./rp/config.d/certs.d/nginx-selfsigned.crt
$ sudo openssl dhparam -out ./rp/config.d/certs.d/dhparam.pem 2048

## Starting

$ docker-compose up


## Cleaning Up

$ docker container rm apache1
$ docker container rm apache2
$ docker container rm reverse
$ docker image rm nginx
$ docker image rm mrdavidknott/craftcms

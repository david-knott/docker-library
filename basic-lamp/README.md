# Simple Lamp

A simple lamp stack that uses a basic Dockerfile. It is assumed there
is an external database that the application can connect.

$ docker build --tag craftcms .

$ docker run --volume /home/david/tmp/:/var/www/web/  --name craftcms-container craftcms

$ docker rm --force craftcms-container


# Simple Lamp Apache with Mod PHP

A simple lamp stack that uses a basic Dockerfile. It is assumed there
is an external database that the application can connect.

$ docker build --tag craftcms .

$ docker run --volume /home/david/tmp/:/var/www/web/  --publish 8080:80  --name craftcms-container craftcms

$ docker rm --force craftcms-container
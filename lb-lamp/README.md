Basic lamp setup with 2 apache backends and one nginx front end.


## Starting

$ docker-compose up


## Cleaning Up

$ docker container rm apache1
$ docker container rm apache2
$ docker container rm reverse
$ docker image rm nginx
$ docker image rm mrdavidknott/craftcms

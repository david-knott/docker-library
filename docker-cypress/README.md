# Docker Image to Test LAMP Website

Self contained docker image with database, php and apache. Database
is initialized from a fixtures host within the network. Additional
scripts allow the updated test database to be saved back to the fixtures
repository. 


## Setup

The following commands remove any previously created images tagged with lamp.
First, a new image is created and then new container is created from that image 
and started. We mount a host directory onto the containers apache vm.

Remove previously created images and rebuild it.
```
docker image rm lamp:latest
docker build -t lamp .
```

Move to directory that contains the webroot folder and execute the following.
This assumes we have access to the live server and its database.
```
docker run --name lampcontainer \
--rm \
--volume $SSH_AUTH_SOCK:/ssh-agent \
--env SSH_AUTH_SOCK=/ssh-agent \
-v $(pwd):/var/www/  \
-p 8080:80 \
-eDB_NAME=sliabhbawnfw_ie \
lamp
```

Updates the fixtures database
```
docker exec -it lampcontainer /update-fixtures.sh
```
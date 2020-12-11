# Hosting Setup

Use ansible recipe that sets up a doceker host.

## Overview

User account dockeru has containers for each wordpress site

Docker container mounts file sstem with project

Single nginx docker image used as front proxy

Single mysql docker image used for hosting, data files on host file system

Single postgres docker image used for hosting, data files on host file system


## Network
We first need to create a network so the sites can communicate with the databases.
 For our purposes a bridge type network will suffice.

```
docker network create --driver bridge dockeru-network
```


## PostgresSetup
Fetch image from docker hub
```
docker pull postgis/postgis
```
Start a postgres instance
```
docker run --name dockeru-postgis  -v /home/dockeru/hosts/postgres/data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=somepassword p 5432:5432  -d postgis/postgis
```
Connect to running instance
```
docker run -it --link dockeru-postgis:postgres --rm postgres \
    sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'
```

## Nginx Setup
```
docker pull nginx
```
Start nginx as root so we can bind to 80 and 443

```
docker run --rm  --name dockeru-nginx -v /home/dockeru/hosts/nginx/nginx.d/:/etc/nginx/conf.d/ -p 80:80 -p 443:443 nginx

```

basic test default.conf
```
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;

    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    #location ~ \.php$ {
    #    root           html;
    #    fastcgi_pass   127.0.0.1:9000;
    #    fastcgi_index  index.php;
    #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    #    include        fastcgi_params;
    #}

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}


```

Live Config

```



events {
    worker_connections  4096;  ## Default: 1024
}

http {

    server {
        listen 443 ssl;
        server_name website1;

        ssl_certificate /etc/nginx/certs.d/nginx-selfsigned.crt;
        ssl_certificate_key /etc/nginx/certs.d/nginx-selfsigned.key;
        ssl_dhparam /etc/nginx/certs.d/dhparam.pem;

        location / {
            proxy_pass http://website1;
        }
    }

    server {
        listen 443 ssl;
        server_name website2;

        ssl_certificate /etc/nginx/certs.d/nginx-selfsigned.crt;
        ssl_certificate_key /etc/nginx/certs.d/nginx-selfsigned.key;
        ssl_dhparam /etc/nginx/certs.d/dhparam.pem;

        location / {
            proxy_pass http://website2;
        }
    }


    server {
        listen 443 ssl;
        server_name website3;

        ssl_certificate /etc/nginx/certs.d/nginx-selfsigned.crt;
        ssl_certificate_key /etc/nginx/certs.d/nginx-selfsigned.key;
        ssl_dhparam /etc/nginx/certs.d/dhparam.pem;

        location / {
            proxy_pass http://website3;
        }
    }

}


```

## Mysql Setup
Fetch image from docker hub
```
docker pull mysql
```
Start a mysql server in docker instance
```
docker run --network dockeru-network --name dockeru-mysql  -v /home/dockeru/hosts/mysql/data:/var/lib/mysql -v /home/dockeru/hosts/mysql/conf.d:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=somepassword  -p 3306:3306  -d mysql:latest
```
Start a mysql client in docker instance
```
docker exec -it dockeru-mysql bash
```


## Wordpress Setup
Custom docker image, fetch image from docker hub
```
docker pull wordpress
```

Start a test site instance.
```
docker run --network dockeru-network  --rm --name test-wordpress  -v /home/dockeru/hosts/website1/files/themes:/var/www/html/wp-content/themes/ -v /home/dockeru/hosts/website1/files/plugins:/var/www/html/wp-content/plugins/  -e WORDPRESS_DB_HOST=dockeru-mysql:3306 -e WORDPRESS_DB_USER=root  -e WORDPRESS_DB_PASSWORD=somepassword -p 8080:80 wordpress
```

Testing wordpress

```
vagrant ssh-config > x
ssh -F x default
ssh -F x default -L 8080:localhost:8080
```

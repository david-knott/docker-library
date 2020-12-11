FROM nginx
COPY ./rp/config.d/nginx.conf /etc/nginx/nginx.conf
COPY ./rp/config.d/certs.d/dhparam.pem /etc/nginx/certs.d/
COPY ./rp/config.d/certs.d/nginx-selfsigned.crt /etc/nginx/certs.d/
COPY ./rp/config.d/certs.d/nginx-selfsigned.key /etc/nginx/certs.d/
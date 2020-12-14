FROM centos:7
# base installation
RUN yum -y install wget git python3 httpd zip unzip zip curl postfix 
RUN wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
RUN rpm -ivh mysql57-community-release-el7-9.noarch.rpm
RUN yum -y install mysql-server
RUN yum -y install epel-release yum-utils
RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php72
RUN yum -y install php-fpm php php-cli php-mysqlnd php-pdo php-gd php-xml php-mbstring php-gettext php-zip curl php-curl php-json 

# Add configuration files.
ADD config/run.sh /run.sh
RUN chmod 755 /*.sh
#ADD config/apache_default /etc/httpd/conf.d/vhost.conf
ADD config/supervisord-php-fpm.conf /etc/supervisor/conf.d/supervisord-php-fpm.conf
ADD config/supervisord-httpd.conf /etc/supervisor/conf.d/supervisord-httpd.conf
ADD config/supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
ADD config/supervisord.conf /etc/supervisor/supervisord.conf

# Supervisor 4 used for running mysql, php-fpm and apache
ENV SUPERVISOR_VERSION=4.2.0
RUN mkdir -p /usr/local/lib/python3.6/site-packages/
RUN mkdir -p /etc/supervisor/
RUN mkdir -p /etc/supervisor/conf.d/
RUN curl -L https://pypi.io/packages/source/s/supervisor/supervisor-${SUPERVISOR_VERSION}.tar.gz | tar xvz && \
  cd supervisor-${SUPERVISOR_VERSION}/ && \
  python3 setup.py install

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

RUN mkdir -p /run/php-fpm/

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

EXPOSE 80 3306
CMD ["/run.sh"]
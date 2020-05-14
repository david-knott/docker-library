FROM centos:7

# Install Apache
RUN yum -y update
RUN yum -y install httpd httpd-tools

# Install EPEL Repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 && rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# Install PHP
RUN yum -y install php72w php72w-dom php72w-gd \
    php72w-opcache php72w-bcmath php72w-cli \
    php72w-common php72w-gd php72w-intl php72w-ldap php72w-mbstring \
    php72w-mysql php72w-pear php72w-soap php72w-xml php72w-xmlrpc \
    libXrender libXext libXtst  fontconfig freetype php72w-intl\
    freetype-devel fontconfig-devel libstdc++ php72w-zip\
    urw-fonts libXext libXrender fontconfig libfontconfig.so.1 \
    php72w-pecl-xdebug.x86_64

# Update Apache Configuration
RUN sed -E -i -e 's/\/var\/www\/html/\/var\/www\/web/g' /etc/httpd/conf/httpd.conf
RUN sed -E -i -e '/<Directory "\/var\/www\/web">/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
RUN sed -E -i -e 's/DirectoryIndex (.*)$/DirectoryIndex index.php \1/g' /etc/httpd/conf/httpd.conf
EXPOSE 80
# Start Apache as systemd is not present
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]

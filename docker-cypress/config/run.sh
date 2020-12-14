#!/bin/bash
echo "Editing main httpd config, setting overrides and directory webroot"
sed -i "s/AllowOverride.*/AllowOverride All/gi" /etc/httpd/conf/httpd.conf
sed -i "s/DocumentRoot \"\/var\/www\/html\"/DocumentRoot \"\/var\/www\/webroot\/\"/gi" /etc/httpd/conf/httpd.conf
sed -i "s/Directory \"\/var\/www\/html\">/Directory \"\/var\/www\/webroot\/\">/gi" /etc/httpd/conf/httpd.conf

mkdir /root/.ssh/ && chmod 700 /root/.ssh && touch /root/.ssh/known_hosts && chmod 644 /root/.ssh/known_hosts
# need to externalise this.
# connect to internal mysql test instance
# pull database named DB_NAME

#ssh-keyscan sliabhbawnwindfarm.ie > /root/.ssh/known_hosts
#DB_PATH=$(ssh sliabhbawnwindfarm.ie@sliabhbawnwindfarm.ie "cd httpdocs;/opt/plesk/php/7.4/bin/php /usr/local/bin/wp db export" | sed -En "s|Success: Exported to '(.+)'\.|\1|p")
#echo "Downloading database $DB_PATH"
#if [ -z "$DB_PATH" ]
#then
#    echo "Cannot fetch database, exiting."
#    exit
#fi
#scp sliabhbawnwindfarm.ie@sliabhbawnwindfarm.ie:~/httpdocs/$DB_PATH /tmp/$DB_NAME
#ssh sliabhbawnwindfarm.ie@sliabhbawnwindfarm.ie "rm -f ~/httpdocs/*.sql"

echo "Initializing Database $DB_NAME."
rm -rf /var/lib/mysql/*
mysqld --initialize-insecure
/usr/sbin/mysqld -uroot > /dev/null 2>&1 &
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done
# create the new database instance.
mysqladmin -uroot create $DB_NAME > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Using existing $DB_NAME."
else 
    mysqldump -uroot -hfixtures.dublin.communicraft.com $DB_NAME > /tmp/$DB_NAME
    mysql -uroot $DB_NAME < /tmp/$DB_NAME
    echo "Database $DB_NAME installed."
fi
exec supervisord -n
echo "Started supervisord"
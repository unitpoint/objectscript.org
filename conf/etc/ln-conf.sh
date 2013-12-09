#!/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

ln -s /home/os/objectscript.org/conf/etc/nginx/nginx.conf /etc/nginx/nginx.conf
ln -s /home/os/objectscript.org/conf/etc/nginx/fastcgi_params /etc/nginx/fastcgi_params
ln -s /home/os/objectscript.org/conf/etc/nginx/ssl.conf /etc/nginx/ssl.conf
ln -s /home/os/objectscript.org/conf/etc/nginx/sites-available/objectscript.org /etc/nginx/sites-available/objectscript.org
# ln -s /etc/nginx/sites-available/objectscript.org /etc/nginx/sites-enabled/objectscript.org




#!/bin/bash

#Preparation for URL redirection

if [ ! -d /var/www/listing ]; then
###echo "Directory not exists, so create it ..."
/bin/mkdir -p /var/www/listing
fi

if [ ! -f /var/www/listing/Inv.csv ]; then
###echo "File not exists, so create it ..."
/bin/touch /var/www/listing/Inv.csv
fi

if [ "$HOSTNAME" == "ip-192-168-30-12.ap-south-1.compute.internal" ]; then
        echo "gedevweb01" > /var/www/local.html
fi

if [ "$HOSTNAME" == "ip-192-168-30-13.ap-south-1.compute.internal" ]; then
        echo "gedevweb02" > /var/www/local.html
fi

/bin/chown -R nginx:nginx /var/www/listing
/bin/chown nginx:nginx /var/www/local.html

exit 0


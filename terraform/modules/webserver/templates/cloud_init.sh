#!/usr/bin/env bash

echo
echo "WEBSERVER CONFIGURATION STARTED"
echo


#####################
# Configure MySQL DB 
#####################
# Make all necessary DB configuration
# from the file, that was placed to random place
mysql < /var/www/html/configure_db.sql



##############################
# Configure Apache Web Server
##############################
# While index.php is in use in our case, default index.html will take a priority. 
# One option is just to remove it.
rm /var/www/html/index.html

chmod 644 /var/www/html/*
chown www-data:www-data /var/www/html/*

systemctl restart apache2



echo
echo
echo
echo "WEBSERVER CONFIGURATION FINISHED"
echo


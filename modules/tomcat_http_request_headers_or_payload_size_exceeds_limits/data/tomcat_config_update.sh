

#!/bin/bash



# Set the configuration file path

CONFIG_FILE=${PATH_TO_TOMCAT_CONFIG_FILE}



# Set the maximum size for HTTP request headers or payload

MAX_SIZE=${NEW_MAXIMUM_SIZE}



# Update the Tomcat configuration file with the new maximum size

sed -i "s/<Connector port=\"8080\"/<Connector port=\"8080\" maxHttpHeaderSize=\"$MAX_SIZE\"/" $CONFIG_FILE



# Restart Tomcat to apply the changes

systemctl restart tomcat
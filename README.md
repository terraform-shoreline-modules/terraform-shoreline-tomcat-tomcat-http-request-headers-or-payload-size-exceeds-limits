
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Tomcat HTTP Request Headers or Payload Size Exceeds Limits.
---

This incident type occurs when the size of HTTP request headers or payload exceeds the limits set by Tomcat server. When this happens, the server may reject the request or return an error message, causing disruption to the normal functioning of the web application. This can be caused by a variety of factors, including large file uploads, excessive use of cookies or query parameters, or attacks that intentionally send oversized requests.

### Parameters
```shell
export PATH_TO_CONFIG_FILE="PLACEHOLDER"

export URL="PLACEHOLDER"

export TOKEN="PLACEHOLDER"

export NEW_MAXIMUM_SIZE="PLACEHOLDER"

export PATH_TO_TOMCAT_CONFIG_FILE="PLACEHOLDER"
```

## Debug

### Check the current open file limit
```shell
ulimit -n
```

### Check the maximum size limit for HTTP requests
```shell
grep -i "LimitRequest" ${PATH_TO_CONFIG_FILE}
```

### Check the maximum size limit for HTTP POST requests
```shell
grep -i "LimitRequestBody" ${PATH_TO_CONFIG_FILE}
```

### Check the current size of the HTTP request headers
```shell
curl -I -X GET -H "Content-Type: application/json" -H "Authorization: Bearer ${TOKEN}" ${URL} | grep -i "content-length"
```

### Check the current size of the HTTP request payload
```shell
curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer ${TOKEN}" ${URL} | wc -c
```

## Repair

### Increase the maximum allowable size for HTTP request headers or payload in Tomcat configuration.
```shell


#!/bin/bash



# Set the configuration file path

CONFIG_FILE=${PATH_TO_TOMCAT_CONFIG_FILE}



# Set the maximum size for HTTP request headers or payload

MAX_SIZE=${NEW_MAXIMUM_SIZE}



# Update the Tomcat configuration file with the new maximum size

sed -i "s/<Connector port=\"8080\"/<Connector port=\"8080\" maxHttpHeaderSize=\"$MAX_SIZE\"/" $CONFIG_FILE



# Restart Tomcat to apply the changes

systemctl restart tomcat


```
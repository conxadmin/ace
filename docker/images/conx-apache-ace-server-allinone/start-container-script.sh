#!/bin/sh
set -e
set -x
# This script will be executed once on a `docker run`.

# start Apache ACE server
# ACE server must be linked to this container under the name "ace" (or somehow else be reachable under the hostname "ace") and must be running on port 8080
java \
      -Dgosh.args=--nointeractive \
      -Dorg.osgi.service.http.port=${HTTP_PORT} \
      -Dorg.apache.ace.server=${ACE_SERVER} \
      -Dorg.apache.ace.obr=${ACE_OBR} \
      -Dosgi.shell.telnet.ip=${OSGI_SHELL_TELNET_IP} \
      -Dosgi.shell.telnet.port=${OSGI_SHELL_TELNET_PORT} \
      -Dosgi.shell.telnet.maxconn=${OSGI_SHELL_TELNET_MAXCONN} \
      -Dosgi.shell.telnet.socketTimeout=${OSGI_SHELL_TELNET_SOCKETTIMEOUT} \
      -jar conx-apache-ace-server-allinone.jar
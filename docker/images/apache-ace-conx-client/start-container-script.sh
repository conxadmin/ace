#!/bin/sh
set -e
set -x
# This script will be executed once on a `docker run`.

# start Apache ACE client
java \
      ${ACE_CLIENT_DEBUG_OPTS} \
      ${ACE_CLIENT_JAVA_OPTS} \
      -Dgosh.args=--nointeractive \
      -Dorg.apache.ace.server=${SOURCE_ORG_APACHE_ACE_SERVER} \
      -Dorg.apache.ace.obr=${SOURCE_ORG_APACHE_ACE_OBR} \
      -Drepo.importer.server=${TARGET_ORG_APACHE_ACE_SERVER} \
      -Drepo.importer.obr=${TARGET_ORG_APACHE_ACE_OBR} \
      -Drepo.importer.targets.path=${REPO_IMPORTER_TARGETS_PATH} \
      -Drepo.importer.path=${REPO_IMPORTER_SOURCE_PATH} \
      -Drepo.exporter.targets="${REPO_EXPORTER_TARGETS}" \
      -Drp.repository.path="${RP_REPO_PATH}" \
      -Dorg.osgi.service.http.port=-1 \
      -Dosgi.shell.telnet.ip=${OSGI_SHELL_TELNET_IP} \
      -Dosgi.shell.telnet.port=${OSGI_SHELL_TELNET_PORT} \
      -Dosgi.shell.telnet.maxconn=${OSGI_SHELL_TELNET_MAXCONN} \
      -Dosgi.shell.telnet.socketTimeout=${OSGI_SHELL_TELNET_SOCKETTIMEOUT} \
      -jar conx-apache-ace-client.jar
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
      -Drepo.exporter.targets="${REPO_EXPORTER_TARGETS}" \
      -Dorg.osgi.service.http.port=-1 \
      -Dace.gogo.script=scripts/copyRepository.gogo \
      -jar conx-apache-ace-script-executor.jar
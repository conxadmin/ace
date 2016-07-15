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
      -Drepo.importer.targets.path=/root/apache_ace_targets \
      -Drepo.exporter.targets="${REPO_EXPORTER_TARGETS}" \
      -Drp.autoconf.bundle="/root/resource_processors/org.apache.felix.deployment.rp.autoconf-0.1.8.jar;org.apache.felix.deployment.rp.autoconf;0.1.8" \
      -Dorg.osgi.service.http.port=-1 \
      -Dace.gogo.script=scripts/copyRepository.gogo \
      -jar conx-apache-ace-script-executor.jar
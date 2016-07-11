#!/bin/sh
set -e
set -x
# This script will be executed once on a `docker run`.

# start Apache ACE server
# ACE server must be linked to this container under the name "ace" (or somehow else be reachable under the hostname "ace") and must be running on port 8080
java \
      ${TARGET_DEBUG_OPTS} \
      ${TARGET_JAVA_OPTS} \
      -Dgosh.args=--nointeractive \
      -Dfelix.log.level=${FELIX_LOG_LEVEL},\
      -Dagent.logging.level=${AGENT_LOGGING_LEVEL} \
      -Dagent.identification.agentid=${AGENT_ID} \
      -Dagent.discovery.serverurls=${AGENT_DISCOVERY_SERVERURLS} \
      -Dagent.controller.syncinterval=${AGENT_CONTROLLER_SYNCINTERVAL} \
      -Dagent.controller.streaming=${AGENT_CONTROLLER_STREAMING} \
      -Dagent.controller.syncdelay=${AGENT_CONTROLLER_SYNCDELAY} \
      -jar conx-apache-ace-target.jar
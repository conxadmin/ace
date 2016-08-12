FROM jeanblanchard/busybox-java:8

MAINTAINER jeanblanchard

# Set env
ENV HTTP_PORT=8080
ENV AGENT_ID "target-mkdev"
ENV AGENT_LOGGING_LEVEL INFO
ENV AGENT_DISCOVERY_SERVERURLS http://localhost:9000
ENV AGENT_CONTROLLER_SYNCINTERVAL 10
ENV AGENT_CONTROLLER_STREAMING true
ENV AGENT_CONTROLLER_SYNCDELAY 5
ENV FELIX_LOG_LEVEL 2
ENV TARGET_JAVA_OPTS "-Xms512m -Xmx1024m -XX:MaxMetaspaceSize=512m"
# ENV TARGET_DEBUG_OPTS "-Xdebug -agentlib:jdwp=transport=dt_socket,address=9999,server=y,suspend=n"
ENV TARGET_DEBUG_OPTS ""
ENV AMDTU_RMT_DSCVR_ETCD_HOST localhost
ENV AMDTU_RMT_DSCVR_ETCD_CONNECTURL http://${AMDTU_RMT_DSCVR_ETCD_HOST}:4001
ENV AMDTU_RMT_DSCVR_ETCD_PORT ${HTTP_PORT}
ENV AMDTU_RMT_DSCVR_ETCD_PATH org.amdatu.remote.discovery.etcd
ENV AMDTU_RMT_DSCVR_ETCD_ROOTPATH /discovery1
ENV AMDTU_RMT_DSCVR_ETCD_SCHEUDULE 4
ENV AMDTU_RMT_ADMIN_HOST localhost
ENV AMDTU_RMT_ADMIN_PORT ${HTTP_PORT}
# install ace target files
COPY distributions/conx-apache-ace-target.jar /root/conx-apache-ace-target.jar
COPY load /root/load/


##################################################################################################
## START CUSTOMIZATION

# Create a mount point
# VOLUME ["/data/apache-ace-target"]

# Expose ports
EXPOSE ${HTTP_PORT}

# Add the Apache Ace start script (executed on a `docker run`).
ADD init-container-script.sh /root/init_apache_ace_target.sh
RUN chmod +x /root/init_apache_ace_target.sh

# Add the Apache Ace start script (executed on a `docker run`).
ADD start-container-script.sh /root/start_apache_ace_target.sh
RUN chmod +x /root/start_apache_ace_target.sh

WORKDIR /root

# Use baseimage-docker's init system.
CMD ["sh","init_apache_ace_target.sh"]


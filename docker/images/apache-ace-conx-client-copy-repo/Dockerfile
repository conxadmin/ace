FROM jeanblanchard/busybox-java:8

MAINTAINER jeanblanchard

# Set env
ENV RP_REPO_PATH=/root/resource_processor_repo/
ENV SOURCE_ORG_APACHE_ACE_SERVER=localhost:8080
ENV SOURCE_ORG_APACHE_ACE_OBR=localhost:8080
ENV TARGET_ORG_APACHE_ACE_SERVER=localhost:8080
ENV TARGET_ORG_APACHE_ACE_OBR=localhost:8080
ENV REPO_EXPORTER_TARGETS=target1;target2
ENV REPO_IMPORTER_TARGETS_PATH=/root/apache_ace_targets
ENV ACE_CLIENT_JAVA_OPTS "-Xms512m -Xmx1024m -XX:MaxMetaspaceSize=512m"
# ENV ACE_CLIENT_DEBUG_OPTS "-Xdebug -agentlib:jdwp=transport=dt_socket,address=9999,server=y,suspend=n"
ENV ACE_CLIENT_DEBUG_OPTS ""
# install ace target files
COPY distributions/conx-apache-ace-script-executor.jar /root/conx-apache-ace-script-executor.jar
COPY conf /root/conf/
COPY targets /root/apache_ace_targets/
COPY resource_processor_repo /root/resource_processor_repo/
COPY gogo_scripts /root/scripts/

##################################################################################################
## START CUSTOMIZATION

# Create a mount point
VOLUME ["/root/apache_ace_targets"]

# Expose ports
#EXPOSE 8080
#EXPOSE 9999

# Add the Apache Ace start script (executed on a `docker run`).
ADD init-container-script.sh /root/init_apache_ace.sh
RUN chmod +x /root/init_apache_ace.sh

# Add the Apache Ace start script (executed on a `docker run`).
ADD start-container-script.sh /root/start_apache_ace.sh
RUN chmod +x /root/start_apache_ace.sh

WORKDIR /root

# Use baseimage-docker's init system.
CMD ["sh","init_apache_ace.sh"]


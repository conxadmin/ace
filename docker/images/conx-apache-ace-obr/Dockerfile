FROM jeanblanchard/busybox-java:8

MAINTAINER jeanblanchard

# Set env
ENV HTTP_PORT 9000
ENV ACE_SERVER localhost:9000
ENV ACE_OBR    localhost:9000
ENV OSGI_SHELL_TELNET_IP 127.0.0.1
ENV OSGI_SHELL_TELNET_PORT 6666
ENV OSGI_SHELL_TELNET_MAXCONN 2
ENV OSGI_SHELL_TELNET_SOCKETTIMEOUT 0

# install ace (for target only)
COPY distributions/conx-apache-ace-obr.jar /root/conx-apache-ace-obr.jar
COPY conf /root/conf/

##################################################################################################
## START CUSTOMIZATION

# Create a mount point
# VOLUME ["/data/apache-ace-server"]

# Expose ports
EXPOSE 6666 8080 9000

# Add the Apache Ace start script (executed on a `docker run`).
ADD init-container-script.sh /root/init_apache_ace_server.sh
RUN chmod +x /root/init_apache_ace_server.sh

# Add the Apache Ace start script (executed on a `docker run`).
ADD start-container-script.sh /root/start_apache_ace_server.sh
RUN chmod +x /root/start_apache_ace_server.sh

WORKDIR /root

# Use baseimage-docker's init system.
CMD ["sh","init_apache_ace_server.sh"]
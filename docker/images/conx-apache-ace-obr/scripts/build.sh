#! /bin/sh

# Make sure that we're setup with the docker machine correctly
eval $(docker-machine env default)

# Build
docker build -t conxadmin/conx-apache-ace-obr .
docker push conxadmin/conx-apache-ace-obr
# Run the apache ace server container first
#docker run -it \
#  --name conx-apache-ace-server-allinone \
#  -e SOURCE_ORG_APACHE_ACE_SERVER localhost:8080 \
#  -e SOURCE_ORG_APACHE_ACE_OBR localhost:8080 \
#  -e REPO_EXPORTER_TARGETS target1;target2 \
#  conxadmin/conx-apache-ace-server-allinone
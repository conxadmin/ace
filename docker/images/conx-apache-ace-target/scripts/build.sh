#! /bin/sh

# Make sure that we're setup with the docker machine correctly
eval $(docker-machine env default)

# Build
docker build -t conxadmin/apache-ace-conx-target .
docker push conxadmin/apache-ace-conx-target
#! /bin/sh

# Make sure that we're setup with the docker machine correctly
eval $(docker-machine env default)

# Build
docker build -t mduduzik/apache-ace-conx-target .

# Run the apache ace server container first
docker run -d \
  -p 8182:8080 \
  --name ace-target-conx-tenantsdb-node1 \
  -e "AGENT_ID=ace-target-conx-tenantsdb-node1" \
  -e "AGENT_DISCOVERY_SERVERURLS=http://aceserver.myconxdev.com:9000" \
  mduduzik/apache-ace-conx-target
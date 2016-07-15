#!/bin/sh

## Where the scripts are
scripts_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
## Where the containers are
images_dir="$(dirname "$scripts_dir")/images"

# Image dirs
# 
# Copy repo client
copy_repo_client_dir=$images_dir/conx-apache-ace-script-executor
# All-in-one-server
allinone_server_dir=$images_dir/conx-apache-ace-server-allinone
# OBR
obr_dir=$images_dir/conx-apache-ace-obr
# Apache ACE target
target_dir=$images_dir/conx-apache-ace-target

# Build images
cd $copy_repo_client_dir
scripts/build.sh
cd $allinone_server_dir
scripts/build.sh
cd $obr_dir
scripts/build.sh
cd $target_dir
scripts/build.sh
#!/bin/sh
# Image dirs
# 
# Copy repo client
copy_repo_client_dir=image/conx-apache-ace-script-executor

# Build images
cd $copy_repo_client_dir
scripts/build_and_run_local.sh
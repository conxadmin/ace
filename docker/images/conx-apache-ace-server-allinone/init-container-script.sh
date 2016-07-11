set -e

# This script will be executed once on a `docker run`.

# Move Apache Ace store folder to the shared volume.
move_apache_ace_store () {
    # Test if /data/apache-ace-server/store is a symlink.
    if [[ -L "/data/apache-ace-server/store" ]]
    then
        echo "Store have already been moved."
    else
        echo "Moving ApacheAce store data."
        # cp -r /root/store /data/apache-ace-server/
        mkdir -p /data/apache-ace-server/store
        rm -r /root/store
        ln -s /data/apache-ace-server/store /root/store
        echo "ApacheAce store data moved, symlinks created."
    fi
}


# STEP 1: move Ace store/obr
#echo " * Assessing Apache Ace store data..."
if [[ -d "/data/apache-ace-server" ]]
then
    echo echo "/data/apache-ace-server store volume exists...moving store"
    move_apache_ace_store
else
    echo "/data/apache-ace-server store volume doesn't exist"
fi

# STEP 2: Run ACE
# start Apache ACE server
# ACE server must be linked to this container under the name "ace" (or somehow else be reachable under the hostname "ace") and must be running on port 8080
sh start_apache_ace_server.sh
set -e

# start Apache ACE target
# ACE target must be linked to this container under the name "ace" (or somehow else be reachable under the hostname "ace") and must be running on port 8080
sh start_apache_ace_target.sh
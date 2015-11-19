#!/bin/bash
set -e

# If the user has run the default command and the socket doesn't exist, fail
if [ "$ETCD_HOST" = "" ]
then
	echo "ETCD_HOST environment not set"
	exit 1
else
	sed -i "s/ETCD_HOST/$ETCD_HOST/g" /etc/confd/confd.toml
fi

exec "$@"

#!/bin/sh
#/var/scripts/check.sh
# Check if pools are healthy. Returns nothing on success.

STATUS=`zpool status -x`

if [ "$STATUS" = "all pools are healthy" ]; then 
    touch /tmp/ok
    exit 0
fi

echo "!!! Possible problem detected !!!"
echo "$STATUS"
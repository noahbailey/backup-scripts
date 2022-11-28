#!/bin/sh
set -e

# Send backups to rsync.net on an hourly schedule
USER="de2243"
SERVER="de2243.rsync.net"

rsync -azh --delete /tank/ "$USER"@"$SERVER":data/

touch /tmp/last_backup
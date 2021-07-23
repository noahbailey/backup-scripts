#!/bin/bash

set -euo pipefail

NOW=$(date +"%Y-%m-%d-%H-%M-%S")
mysqldump nextcloud | gzip > /opt/mysql-backups/nextcloud-$NOW.sql.gz
find /opt/mysql-backups/ -mtime +7 -delete

# Sync backups to server
rsync -azh --delete  --progress /opt/mysql-backups/ ncbackup@nas.intranet.nbailey.ca:/tank/nextcloud/database/

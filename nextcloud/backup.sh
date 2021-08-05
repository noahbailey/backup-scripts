#!/bin/bash

SERVER="beastie.intranet.nbailey.ca"

## Backup the database
NOW=$(date +"%Y-%m-%d-%H-%M-%S")
mysqldump nextcloud | gzip > /opt/mysql-backups/nextcloud-"$NOW".sql.gz
find /opt/mysql-backups/ -mtime +7 -delete

# Sync database backups to server
rsync -azh --delete /opt/mysql-backups/ ncbackup@"$SERVER":/tank/nextcloud/database/

# Sync nextcloud directory to server
rsync -azh --delete /var/www/nextcloud  ncbackup@"$SERVER":/tank/nextcloud/backup/

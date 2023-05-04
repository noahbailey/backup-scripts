#!/bin/bash

SERVER="beastie.intranet.nbailey.ca"

## Backup the database
NOW=$(date +"%Y-%m-%d-%H-%M-%S")
echo "--- Starting backup at $NOW ---" >> /tmp/backup.log
echo "Destination: $SERVER" >> /tmp/backup.log

mysqldump nextcloud | gzip > /opt/mysql-backups/nextcloud-"$NOW".sql.gz
find /opt/mysql-backups/ -mtime +7 -delete

# Sync database backups to server
rsync -azhi --delete /opt/mysql-backups/ ncbackup@"$SERVER":/tank/nextcloud/database/ >> /tmp/backup.log

# Sync nextcloud directory to server
rsync -azhi --delete /var/www/nextcloud  ncbackup@"$SERVER":/tank/nextcloud/backup/ >> /tmp/backup.log

# Finish backup run
echo "--- Done backup at $NOW ---" >> /tmp/backup.log

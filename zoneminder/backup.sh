#!/bin/bash

SERVER="beastie.intranet.nbailey.ca"

## Backup the database
NOW=$(date +"%Y-%m-%d-%H-%M-%S")
mysqldump zm | gzip > /opt/mysql-backups/zoneminder-"$NOW".sql.gz
find /opt/mysql-backups/ -mtime +7 -delete

# Sync database backups to server
rsync -azh --delete /opt/mysql-backups/ zmbackup@"$SERVER":/tank/zoneminder/database/

# Sync zoneminder directory to server
rsync -azh --delete /var/cache/zoneminder/  zmbackup@"$SERVER":/tank/zoneminder/archive/

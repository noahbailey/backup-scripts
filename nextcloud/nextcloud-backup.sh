#!/bin/bash

rsync -azh --delete  --progress /var/www/nextcloud ncbackup@beastie.intranet.nbailey.ca:/tank/nextcloud/backup/

#!/bin/bash
set -eo pipefail

NOW=$(date +"%Y-%m-%d-%H-%M-%S")
SERVER="beastie.intranet.nbailey.ca"

pg_dump mastodon_production | gzip > /home/mastodon/backups/mastodon_production-$NOW.sql.gz
find /home/mastodon/backups/ -type f -mtime +14 -delete

rsync -azh --delete /home/mastodon/ mastobackup@beastie.intranet.nbailey.ca:/tank/mastodon/data/

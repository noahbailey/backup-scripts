#!/bin/bash
set -eEuo pipefail

trap 'notify-send "Backup failure..."' ERR

NOW=$(date +"%Y-%m-%d-%H-%M-%S")

# Export list of installed packages
mkdir -p ~/.apt/{lists,keys}
dpkg --get-selections > ~/.apt/pkglist
cp -R /etc/apt/sources.list.d/* ~/.apt/lists
cp -R /etc/apt/trusted.gpg* ~/.apt/keys/

# Sync to backup server
rsync -iazh --delete --exclude-from="/home/$USER/.local/share/backup/exclude" \
    ~/ beastie.intranet.nbailey.ca:/tank/backups/computer/home

echo "$NOW" > ~/.local/share/backup/lastbackup

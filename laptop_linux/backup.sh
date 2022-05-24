#!/bin/bash
set -eEuo pipefail

trap 'notify-send "Backup failure..."' ERR

# Export list of installed packages
mkdir -p ~/.apt/{lists,keys}
dpkg --get-selections > ~/.apt/pkglist
cp -R /etc/apt/sources.list.d/* ~/.apt/lists
cp -R /etc/apt/trusted.gpg* ~/.apt/keys/

# Sync to backup server
rsync -azh --delete --exclude={'.cache','.thunderbird','.mozilla','.config/discord','.config/Slack','.config/Signal','.config/Element','.config/1Password/','.config/Code'} \
    ~/ beastie.intranet.nbailey.ca:/tank/backups/computer/home

touch ~/.local/share/backup.date

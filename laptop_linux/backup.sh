#!/bin/bash
set -eEuo pipefail

trap 'notify-send "Backup failure..."' ERR

NOW=$(date +"%Y-%m-%d-%H-%M-%S")
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$UID/bus"

## Source settings file:
source "/home/$USER/.local/share/backup/backup.conf"

# Export list of installed packages
mkdir -p ~/.apt/{lists,keys}
dpkg --get-selections > ~/.apt/pkglist
cp -R /etc/apt/sources.list.d/* ~/.apt/lists
cp -R /etc/apt/trusted.gpg* ~/.apt/keys/

# Attempt to ping the backup server
#  This will fail with status >2 if offline/unreachable
ping -c1 "$HOST" 1>/dev/null

# Sync to backup server
rsync -iazh --delete --exclude-from="/home/$USER/.local/share/backup/exclude" \
   ~/ \
   "$HOST:/tank/backups/computer/home"

echo "$NOW" > ~/.local/share/backup/lastbackup

if [ "$NOTIFY_SUCCESS" = true ]; then
    notify-send "Backup successful."
fi

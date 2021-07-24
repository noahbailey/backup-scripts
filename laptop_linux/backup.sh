#!/bin/bash

# Export list of installed packages
pacman -Qe > .pkglist

# Sync to backup server
rsync -azh --delete --exclude={'.cache','.thunderbird','.mozilla'} --progress ~/ beastie.intranet.nbailey.ca:/tank/backups/polygon/home

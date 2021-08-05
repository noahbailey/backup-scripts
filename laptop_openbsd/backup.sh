#!/usr/local/bin/bash

# Export list of installed packages
pkg_info -mz > .pkglist

# Sync to backup server
rsync -azh --delete --exclude={'.cache','.thunderbird','.mozilla'} ~/ beastie.intranet.nbailey.ca:/tank/backups/scootypuff/home/

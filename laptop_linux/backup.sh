#!/bin/bash

# Export list of installed packages
pacman -Qe > .pkglist

# Sync to backup server
rsync -azh --delete --exclude={'.cache','.thunderbird','.mozilla','.config/discord','.config/Slack','.config/Signal','.config/Element','.config/1Password/','.config/VSCodium'} \
    --progress ~/ beastie.intranet.nbailey.ca:/tank/backups/polygon/home

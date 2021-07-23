#!/bin/bash

rsync -azh --delete --exclude '.cache' --progress ~/ beastie.intranet.nbailey.ca:/tank/backups/$HOSTNAME/home

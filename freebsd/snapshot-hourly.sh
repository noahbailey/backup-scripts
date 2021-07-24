#!/bin/sh
# /var/scripts/snapshot-hourly.sh
# Script to take snapshots hourly and retain for one day

# Get total number of snapshots
NUM_SNAPSHOTS=`zfs list -t snapshot tank | awk '/@/{print $1}' | wc -l`

# Find earliest snapshot
OLDEST_SNAPSHOT=`zfs list -t snapshot tank | grep hourly | head -n1 | awk '{print $1}'`

# Take a snapshot marked current time
zfs snapshot -r tank@hourly-"`date '+%Y%m%d-%H%M'`"

# Remove oldest hourly snapshot
if [ "$NUM_SNAPSHOTS" -gt 24 ]; then 
    zfs destroy -r -v "$OLDEST_SNAPSHOT" >> /var/log/snapshot.log
fi

#!/bin/sh
# /var/scripts/snapshot-daily.sh
# Script to take snapshots daily and retain for one day

# Get total number of snapshots
NUM_SNAPSHOTS=`zfs list -t snapshot tank | awk '/@/{print $1}' | wc -l`

# Find earliest snapshot
OLDEST_SNAPSHOT=`zfs list -t snapshot tank | grep daily | head -n1 | awk '{print $1}'`

# Take a snapshot marked current time
zfs snapshot -r tank@daily-"`date '+%Y%m%d-%H%M'`"

# Remove oldest daily snapshot
if [ $NUM_SNAPSHOTS -gt 60 ]; then 
    zfs destroy -r -v "$OLDEST_SNAPSHOT" >> /var/log/snapshot.log
fi

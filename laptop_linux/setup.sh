#!/bin/bash
set -eEuo pipefail

mkdir -p ~/.config/systemd/user/
mkdir -p ~/.local/share/systemd/

cat << EOF | tee ~/.config/systemd/user/backup.timer
[Unit]
Description=System backup timer

[Timer]
OnCalendar=*-*-* 06,12,18:00:00
OnCalendar=Daily
Persistent=true
RandomizedDelaySec=120
OnBootSec=300s

[Install]
WantedBy=timers.target
EOF

cat << EOF | tee ~/.config/systemd/user/backup.service
[Unit]
Description=FooBar
After=network.target

[Service]
Type=oneshot
ExecStart=/home/noah/.local/bin/backup.sh
EOF

systemctl --user daemon-reload
systemctl --user enable --now backup.timer

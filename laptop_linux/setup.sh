#!/bin/bash
set -eEuo pipefail

mkdir -p ~/.config/systemd/user/
mkdir -p ~/.local/share/systemd/
mkdir -p ~/.local/share/backup/

cp exclude ~/.local/share/backup/

cat << EOF | tee ~/.config/systemd/user/backup.timer
[Unit]
Description=System backup timer

[Timer]
OnCalendar=Hourly
Persistent=true
RandomizedDelaySec=600
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

#!/bin/bash
set -eEuo pipefail

mkdir -p ~/.config/systemd/user/
mkdir -p ~/.local/share/systemd/
mkdir -p ~/.local/share/backup/

cp exclude ~/.local/share/backup/
cp backup.conf ~/.local/share/backup/

cat << EOF | tee ~/.config/systemd/user/backup.timer
[Unit]
Description=System backup timer
After=network.target

[Timer]
OnCalendar=*-*-* 13:30
OnCalendar=Hourly
Persistent=true
RandomizedDelaySec=1800
OnBootSec=300s

[Install]
WantedBy=timers.target
EOF

cat << EOF | tee ~/.config/systemd/user/backup.service
[Unit]
Description=System Backup
After=network.target
StartLimitBurst=3

[Service]
Type=oneshot
Restart=on-failure
RestartSec=60s
ExecStart=/home/noah/.local/bin/backup.sh
EOF

systemctl --user daemon-reload
systemctl --user enable --now backup.timer

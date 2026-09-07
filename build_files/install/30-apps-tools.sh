#!/bin/bash

set -euo pipefail

## Install Anydesk
tee /etc/yum.repos.d/AnyDesk-RPM.repo > /dev/null << "EOF"
[anydesk]
name=AnyDesk - stable
baseurl=http://rpm.anydesk.com/$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF

dnf install -y \
    anydesk \
    nautilus \
    gnome-disk-utility \
    fish \
    kitty

curl --retry 3 -fsSL https://starship.rs/install.sh | sh -s -- \
    --yes \
    --bin-dir /usr/local/bin

systemctl enable ublue-os-media-automount.service
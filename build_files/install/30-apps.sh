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

dnf install -y anydesk
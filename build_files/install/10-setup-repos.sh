#!/bin/bash

set -euo pipefail

FEDORA_VERSION="$(rpm -E '%{fedora}')"

dnf5 config-manager addrepo --from-repofile="https://copr.fedorainfracloud.org/coprs/ublue-os/packages/repo/fedora-${FEDORA_VERSION}/ublue-os-packages-fedora-${FEDORA_VERSION}.repo"
dnf5 config-manager setopt copr:copr.fedorainfracloud.org:ublue-os:packages.enabled=0

dnf5 config-manager addrepo --from-repofile="https://raw.githubusercontent.com/terrapkg/subatomic-repos/main/terra.repo"
dnf5 config-manager setopt terra.enabled=0

tee /etc/yum.repos.d/AnyDesk-RPM.repo >/dev/null <<"EOF"
[anydesk]
name=AnyDesk - stable
baseurl=http://rpm.anydesk.com/$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF

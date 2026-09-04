#!/bin/bash

set -euo pipefail

FEDORA_VERSION="$(rpm -E '%{fedora}')"

dnf5 config-manager addrepo --from-repofile="https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland/repo/fedora-${FEDORA_VERSION}/lionheartp-Hyprland-fedora-${FEDORA_VERSION}.repo"
dnf5 config-manager setopt copr:copr.fedorainfracloud.org:lionheartp:Hyprland.enabled=0

dnf5 config-manager addrepo --from-repofile="https://copr.fedorainfracloud.org/coprs/avengemedia/danklinux/repo/fedora-${FEDORA_VERSION}/avengemedia-danklinux-fedora-${FEDORA_VERSION}.repo"
dnf5 config-manager setopt copr:copr.fedorainfracloud.org:avengemedia:danklinux.enabled=0

dnf5 config-manager addrepo --from-repofile="https://copr.fedorainfracloud.org/coprs/avengemedia/dms-git/repo/fedora-${FEDORA_VERSION}/avengemedia-dms-git-fedora-${FEDORA_VERSION}.repo"
dnf5 config-manager setopt copr:copr.fedorainfracloud.org:avengemedia:dms-git.enabled=0

dnf5 install -y \
    --enablerepo=copr:copr.fedorainfracloud.org:lionheartp:Hyprland \
    --enablerepo=copr:copr.fedorainfracloud.org:avengemedia:danklinux \
	--enablerepo=copr:copr.fedorainfracloud.org:avengemedia:dms-git \
    hyprland \
    hyprland-guiutils \
    dms \
    dms-greeter



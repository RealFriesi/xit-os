#!/bin/bash

set -euo pipefail

FEDORA_VERSION="$(rpm -E '%{fedora}')"

dnf5 config-manager addrepo --from-repofile="https://copr.fedorainfracloud.org/coprs/ublue-os/packages/repo/fedora-${FEDORA_VERSION}/ublue-os-packages-fedora-${FEDORA_VERSION}.repo"
dnf5 config-manager setopt copr:copr.fedorainfracloud.org:ublue-os:packages.enabled=0

dnf5 config-manager addrepo --from-repofile="https://raw.githubusercontent.com/terrapkg/subatomic-repos/main/terra.repo"
dnf5 config-manager setopt terra.enabled=0

dnf5 install -y \
    --enablerepo=copr:copr.fedorainfracloud.org:ublue-os:packages \
    --enablerepo=terra \
    ublue-os-media-automount-udev \
    xwayland-satellite \
    noctalia \
    noctalia-greeter \
    umbriel-nightly \
    adw-gtk3-theme \
	qt6ct \
    gnome-keyring \
	gnome-keyring-pam

systemctl enable greetd.service
systemctl set-default graphical.target
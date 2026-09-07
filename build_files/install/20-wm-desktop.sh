#!/bin/bash

set -euo pipefail

FEDORA_VERSION="$(rpm -E '%{fedora}')"

dnf5 config-manager addrepo --from-repofile="https://raw.githubusercontent.com/terrapkg/subatomic-repos/main/terra.repo"
dnf5 config-manager setopt terra.enabled=0

dnf5 install -y \
    --enablerepo=terra \
    xwayland-satellite \
    noctalia \
    noctalia-greeter \
    umbriel-nightly \
    adw-gtk3-theme \
	hyprqt6engine \
    gnome-keyring \
	gnome-keyring-pam \
    accountsservice


systemctl enable greetd.service
systemctl set-default graphical.target
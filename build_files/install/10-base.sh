#!/bin/bash

set -euo pipefail

dnf5 config-manager addrepo --from-repofile="https://copr.fedorainfracloud.org/coprs/ublue-os/packages/repo/fedora-${FEDORA_VERSION}/ublue-os-packages-fedora-${FEDORA_VERSION}.repo"
dnf5 config-manager setopt copr:copr.fedorainfracloud.org:ublue-os:packages.enabled=0

dnf5 install -y \
	--enablerepo=copr:copr.fedorainfracloud.org:ublue-os:packages \
	dnf5-plugins \
	distrobox \
	fish \
	flatpak \
	fuse \
	fuse-libs \
	bluez \
	btrfs-progs \
	cryptsetup \
	fwupd \
	ublue-os-media-automount-udev \
	glibc-all-langpacks \
	langpacks-de \
	langpacks-en \
	openvpn \
	NetworkManager \
	NetworkManager-openvpn \
	pipewire \
	pipewire-pulseaudio \
	plymouth \
	polkit \
	power-profiles-daemon \
	udisks2 \
	wireplumber \
	xdg-user-dirs

## Font
font_dir=/usr/share/fonts/FiraCode
font_archive=/tmp/FiraCode.zip
mkdir -p "${font_dir}"
curl --retry 3 -fsSL \
        -o "${font_archive}" \
        https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip -q "${font_archive}" -d "${font_dir}"
rm -f "${font_archive}"
fc-cache -f "${font_dir}"
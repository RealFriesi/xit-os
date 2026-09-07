#!/bin/bash

set -euo pipefail



dnf5 install -y \
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

flatpak remote-add --if-not-exists --system flathub https://dl.flathub.org/repo/flathub.flatpakrepo

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
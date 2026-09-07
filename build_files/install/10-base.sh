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

#!/bin/bash

set -euo pipefail

dnf5 install -y \
	--enablerepo=copr:copr.fedorainfracloud.org:ublue-os:packages \
	ublue-os-media-automount-udev \
	plymouth \
	plymouth-theme-charge \
	distrobox \
	fuse \
	fuse-libs \
	uresourced \
	dosfstools \
	exfatprogs \
	ntfs-3g \
	ntfsprogs \
	bluez \
	btrfs-progs \
	cryptsetup \
	dbus-daemon \
	fwupd \
	fprintd \
	fprintd-pam \
	langpacks-de \
	langpacks-en \
	openvpn \
	NetworkManager \
	NetworkManager-openvpn \
	NetworkManager-wifi \
	realmd \
	sssd \
	oddjob \
	oddjob-mkhomedir \
	adcli \
	samba-common-tools \
	wpa_supplicant \
	iwlwifi-mvm-firmware \
	pipewire \
	pipewire-pulseaudio \
	polkit \
	lm_sensors \
	tuned \
	tuned-ppd \
	udisks2 \
	wireplumber \
	xdg-user-dirs

plymouth-set-default-theme -R charge
systemctl enable podman.socket

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

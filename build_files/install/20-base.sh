#!/bin/bash

set -euo pipefail

dnf5 install -y \
	--enablerepo=copr:copr.fedorainfracloud.org:ublue-os:packages \
	--skip-unavailable \
	@multimedia \
	ublue-os-media-automount-udev \
	ublue-os-udev-rules \
	lm_sensors \
	tuned \
	tuned-ppd \
	uresourced \
	dosfstools \
	exfatprogs \
	ntfs-3g \
	ntfsprogs \
	amd-ucode-firmware \
	microcode_ctl \
	distrobox \
	fish \
	fuse \
	fuse-libs \
	btrfs-progs \
	cryptsetup \
	langpacks-de \
	langpacks-en \
	wpa_supplicant \
	iwlwifi-mvm-firmware \
	realmd \
	sssd \
	oddjob \
	oddjob-mkhomedir \
	adcli \
	samba-common-tools \
	plymouth \
	plymouth-theme-charge \
	gnome-keyring \
	gnome-keyring-pam

plymouth-set-default-theme -R charge

systemctl enable podman.socket
systemctl enable ublue-os-media-automount.service
systemctl enable tuned.service
systemctl enable tuned-ppd.service
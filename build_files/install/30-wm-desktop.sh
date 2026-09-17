#!/bin/bash

set -euo pipefail

dnf5 install -y \
	--enablerepo=copr:copr.fedorainfracloud.org:ublue-os:packages \
	--exclude=baobab \
	--exclude=epiphany \
	--exclude=evince \
	--exclude=firefox \
	--exclude=gnome-calendar \
	--exclude=gnome-calculator \
	--exclude=gnome-software \
	--exclude=gnome-text-editor \
	--exclude=loupe \
	--exclude=papers \
	--exclude=ptyxis \
	@gnome-desktop \
	gnome-initial-setup \
	ublue-os-media-automount-udev \
	gnome-keyring \
	gnome-keyring-pam \
	xdg-desktop-portal \
	xdg-desktop-portal-gnome \
	xdg-desktop-portal-gtk

systemctl enable gdm.service
systemctl set-default graphical.target

dconf update

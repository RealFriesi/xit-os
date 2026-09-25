#!/bin/bash

set -euo pipefail

dnf5 install -y \
	--exclude=baobab \
	--exclude=firefox \
	--exclude=gnome-calendar \
	--exclude=gnome-calculator \
	--exclude=gnome-software \
	--exclude=gnome-text-editor \
	--exclude=gnome-characters \
	--exclude=gnome-classic-session \
	--exclude=gnome-clocks \
	--exclude=gnome-color-manager \
	--exclude=gnome-connections \
	--exclude=gnome-contacts \
	--exclude=gnome-font-viewer \
	--exclude=gnome-logs \
	--exclude=gnome-maps \
	--exclude=gnome-weather \
	--exclude=showtime \
	--exclude=simple-scan \
	--exclude=snapshot \
	--exclude=loupe \
	--exclude=papers \
	--exclude=ptyxis \
	--exclude=decibels \
	@gnome-desktop \
	qt6-qtbase \
	qt6-qtbase-gui \
	qt6-qtdeclarative \
	qt6-qtwayland-adwaita-decoration \
	ublue-os-media-automount-udev \
	gnome-keyring \
	gnome-keyring-pam \
	xdg-utils \
	xdg-desktop-portal \
	xdg-desktop-portal-gnome \
	xdg-desktop-portal-gtk

systemctl enable gdm.service
systemctl set-default graphical.target

dconf update

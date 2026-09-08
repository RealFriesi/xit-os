#!/bin/bash

set -euo pipefail

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

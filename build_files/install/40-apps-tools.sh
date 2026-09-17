#!/bin/bash

set -euo pipefail

dnf install -y \
	anydesk \
	nautilus \
	nautilus-python \
	gvfs \
	gvfs-afc \
	gvfs-archive \
	gvfs-client \
	gvfs-fuse \
	gvfs-goa \
	gvfs-gphoto2 \
	gvfs-mtp \
	gvfs-smb \
	gnome-disk-utility \
	fish \
	kitty

curl --retry 3 -fsSL https://starship.rs/install.sh | sh -s -- \
	--yes \
	--bin-dir /usr/local/bin

useradd -D --shell /usr/bin/fish

systemctl enable ublue-os-media-automount.service

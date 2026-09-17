#!/bin/bash

set -euo pipefail

dnf install -y \
	--enablerepo=terra \
	--enablerepo=anydesk \
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
	ghostty

shader_dir=/usr/share/xit-os/ghostty/shaders
shader_archive=/tmp/ghostty-cursor-shaders.tar.gz
mkdir -p "${shader_dir}"
curl --retry 3 -fsSL \
	-o "${shader_archive}" \
	https://github.com/sahaj-b/ghostty-cursor-shaders/archive/refs/heads/main.tar.gz
tar -xzf "${shader_archive}" \
	-C "${shader_dir}" \
	--strip-components=1 \
	--wildcards '*.glsl'

flatpak --system --noninteractive preinstall

curl --retry 3 -fsSL https://starship.rs/install.sh | sh -s -- \
	--yes \
	--bin-dir /usr/local/bin

useradd -D --shell /usr/bin/fish

systemctl enable ublue-os-media-automount.service

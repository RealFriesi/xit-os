#!/bin/bash

set -euo pipefail

dnf install -y \
    --skip-unavailable \
	--enablerepo=terra \
	--enablerepo=anydesk \
	anydesk \
	gnome-disk-utility \
	unzip \
	fish \
	ghostty

# Install Ghostty Shaders
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

# Install Nautilus OpenVPN Extension
nautilus_extension_dir=/usr/lib64/nautilus/extensions-4
mkdir -p "${nautilus_extension_dir}"
curl --retry 3 -fsSL \
	-o "${nautilus_extension_dir}/libnautilus_ovpn.so" \
	https://github.com/RealFriesi/nautilus-ovpn/releases/latest/download/libnautilus_ovpn.so

nautilus_locale_dir=/usr/share/locale/de/LC_MESSAGES
mkdir -p "${nautilus_locale_dir}"
curl --retry 3 -fsSL \
	-o "${nautilus_locale_dir}/nautilus-ovpn.mo" \
	https://github.com/RealFriesi/nautilus-ovpn/releases/latest/download/nautilus-ovpn.mo

# Install Starship
curl --retry 3 -fsSL https://starship.rs/install.sh | sh -s -- \
	--yes \
	--bin-dir /usr/local/bin

useradd -D --shell /usr/bin/fish
usermod --shell /usr/bin/fish root

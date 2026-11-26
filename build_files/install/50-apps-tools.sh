#!/bin/bash

set -euo pipefail

dnf install -y \
	--skip-unavailable \
	--enablerepo=terra \
	--enablerepo=anydesk \
	anydesk \
	fish \
	fuse-libs \
	ghostty \
	jq

# Install Starship
curl --retry 3 -fsSL https://starship.rs/install.sh | sh -s -- \
	--yes \
	--bin-dir /usr/local/bin

useradd -D --shell /usr/bin/fish
usermod --shell /usr/bin/fish root

# Install ActivityWatch
AW_TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$AW_TMP_DIR"' EXIT

curl --retry 3 -fsSL https://api.github.com/repos/ActivityWatch/activitywatch/releases/latest \
	-o "${AW_TMP_DIR}/release.json"
AW_RELEASE_ASSET="$(jq -er 'first(.assets[] | select(.name | test("^activitywatch-tauri-v[0-9].*-linux-x86_64\\.AppImage$"))) | [.browser_download_url, .digest] | @tsv' "${AW_TMP_DIR}/release.json")"
IFS=$'\t' read -r AW_DOWNLOAD_URL AW_DIGEST <<<"$AW_RELEASE_ASSET"
AW_SHA256="${AW_DIGEST#sha256:}"

curl --retry 3 -fsSL "$AW_DOWNLOAD_URL" \
	-o "${AW_TMP_DIR}/aw-tauri.AppImage"
printf '%s  %s\n' "$AW_SHA256" "${AW_TMP_DIR}/aw-tauri.AppImage" | sha256sum --check --status
install -D -m 0755 "${AW_TMP_DIR}/aw-tauri.AppImage" /opt/activitywatch/aw-tauri.AppImage

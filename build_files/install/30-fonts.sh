#!/bin/bash

set -euo pipefail

dnf5 install -y \
	default-fonts-core-sans \
	default-fonts-core-emoji \
	default-fonts-cjk-sans \
	default-fonts-core-mono

nerd_font_archives=(
	FiraCode.zip
	Hack.zip
	Meslo.zip
	GeistMono.zip
	NerdFontsSymbolsOnly.zip
)

font_base_dir=/usr/share/fonts
font_dirs=()

for font_archive_name in "${nerd_font_archives[@]}"; do
	font_name="${font_archive_name%.zip}"
	font_dir="${font_base_dir}/${font_name}"
	font_archive="/tmp/${font_archive_name}"

	mkdir -p "${font_dir}"
	font_dirs+=("${font_dir}")
	curl --retry 3 -fsSL \
		-o "${font_archive}" \
		"https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font_archive_name}"
	unzip -q "${font_archive}" -d "${font_dir}"
	rm -f "${font_archive}"
done

fc-cache -f "${font_dirs[@]}"

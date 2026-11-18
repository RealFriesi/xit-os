#!/bin/bash

set -euo pipefail

dnf install -y \
	--skip-unavailable \
	--enablerepo=terra \
	--enablerepo=anydesk \
	anydesk \
	fish \
	ghostty

# Install Starship
curl --retry 3 -fsSL https://starship.rs/install.sh | sh -s -- \
	--yes \
	--bin-dir /usr/local/bin

useradd -D --shell /usr/bin/fish
usermod --shell /usr/bin/fish root

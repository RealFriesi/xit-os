#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

mapfile -t installers < <(find /ctx/install -maxdepth 1 -name '*.sh' | LC_ALL=C sort -V)
for installer in "${installers[@]}"; do
	printf 'Running %s\n' "${installer}"
	bash "${installer}"
done

KVER="$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-core | sort -V | tail -n1)"
depmod -a "${KVER}"
export DRACUT_NO_XATTR=1
dracut --force --no-hostonly --reproducible --zstd -v \
	--add ostree \
	--kver "${KVER}" \
	-f "/usr/lib/modules/${KVER}/initramfs.img"
chmod 0600 "/usr/lib/modules/${KVER}/initramfs.img"

systemctl enable podman.socket

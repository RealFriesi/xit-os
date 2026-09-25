#!/bin/bash

set -ouex pipefail

# Rebuild the initramfs so it matches the kernel installed by the install scripts.
KVER="$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-core | sort -V | tail -n1)"
depmod -a "${KVER}"
export DRACUT_NO_XATTR=1
dracut --force --no-hostonly --reproducible --zstd -v \
	--add ostree \
	--kver "${KVER}" \
	-f "/usr/lib/modules/${KVER}/initramfs.img"
chmod 0600 "/usr/lib/modules/${KVER}/initramfs.img"

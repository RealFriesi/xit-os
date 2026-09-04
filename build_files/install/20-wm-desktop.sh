#!/bin/bash

set -euo pipefail

FEDORA_VERSION="$(rpm -E '%{fedora}')"

dnf5 config-manager addrepo --from-repofile="https://copr.fedorainfracloud.org/coprs/avengemedia/dms-git/repo/fedora-${FEDORA_VERSION}/avengemedia-dms-git-fedora-${FEDORA_VERSION}.repo"
dnf5 config-manager setopt copr:copr.fedorainfracloud.org:avengemedia:dms-git.enabled=0

dnf5 install -y \
	--enablerepo=copr:copr.fedorainfracloud.org:avengemedia:dms-git \
    dms
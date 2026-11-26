#!/bin/bash

set -euo pipefail

dnf5 install -y \
	--enablerepo=copr:copr.fedorainfracloud.org:ublue-os:packages \
	--skip-unavailable \
	zram-generator

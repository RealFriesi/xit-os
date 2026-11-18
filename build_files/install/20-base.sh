#!/bin/bash

set -euo pipefail

dnf5 install -y \
	--enablerepo=copr:copr.fedorainfracloud.org:ublue-os:packages \
	--skip-unavailable \
	zram-generator

#systemctl --global mask gcr-ssh-agent.socket gcr-ssh-agent.service

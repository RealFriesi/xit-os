#!/bin/bash
# Generate the default DankMaterialShell configuration and seed it into
# /etc/skel.
#
# `dms setup headless` writes exclusively to $HOME/XDG paths (there is no
# override for the settings directory), refuses to run as root, and is blocked
# by the DMS immutable-system policy. So it is run once here as an unprivileged
# throwaway user against a temporary HOME, with the policy lifted for the
# duration of the build, and the result is copied into /etc/skel.
#
# The generated configuration is pure Lua (hyprland.lua + hypr/dms/*.lua); DMS
# never emits hyprlang .conf files for Hyprland any more.

set -euo pipefail

TERMINAL="ghostty"
BUILD_USER="dmsbuild"
BUILD_HOME="/var/tmp/${BUILD_USER}"
SKEL="/etc/skel"
POLICY="/etc/dms/cli-policy.json"
POLICY_BACKUP="/var/tmp/cli-policy.runtime.json"

cleanup() {
	userdel --force "${BUILD_USER}" 2>/dev/null || true
	rm -rf "${BUILD_HOME}"
	# Restore the runtime policy shipped in system_files/etc/dms/cli-policy.json.
	install -Dpm0644 "${POLICY_BACKUP}" "${POLICY}"
	rm -f "${POLICY_BACKUP}"
}

install -Dpm0644 "${POLICY}" "${POLICY_BACKUP}"
trap cleanup EXIT

# Lift the immutable-system block for the build. Whether it triggers depends on
# the os-release fields of the base image, so do not rely on it being inactive.
cat >"${POLICY}" <<'EOF'
{
  "policy_version": 1,
  "immutable_system": false,
  "blocked_commands": []
}
EOF

rm -rf "${BUILD_HOME}"
useradd --system --no-create-home --home-dir "${BUILD_HOME}" --shell /sbin/nologin "${BUILD_USER}"
install -d -o "${BUILD_USER}" -g "${BUILD_USER}" -m 0700 "${BUILD_HOME}" "${BUILD_HOME}/run"

# dms resolves every path through XDG with a $HOME fallback; pin all of them so
# nothing can escape into the real filesystem.
run_as_build_user() {
	setpriv --reuid "${BUILD_USER}" --regid "${BUILD_USER}" --init-groups \
		env -i \
		PATH=/usr/bin:/bin \
		HOME="${BUILD_HOME}" \
		XDG_CONFIG_HOME="${BUILD_HOME}/.config" \
		XDG_STATE_HOME="${BUILD_HOME}/.local/state" \
		XDG_DATA_HOME="${BUILD_HOME}/.local/share" \
		XDG_CACHE_HOME="${BUILD_HOME}/.cache" \
		XDG_RUNTIME_DIR="${BUILD_HOME}/run" \
		"$@"
}

# The terminal must already be installed: its presence decides the command that
# `dms setup` substitutes into the SUPER+T keybind.
command -v "${TERMINAL}" >/dev/null

run_as_build_user dms setup headless --compositor hyprland --terminal "${TERMINAL}" --force

GENERATED="${BUILD_HOME}/.config"

# Drop what the image provides system-wide. Left in /etc/skel these would
# shadow /usr/lib/systemd/user and /usr/lib/environment.d in every new home and
# freeze them at build time.
rm -rf "${GENERATED}/systemd" "${GENERATED}/environment.d"

# Backup directories carry a timestamp; they must never reach the image.
rm -rf "${GENERATED}/hypr/.dms-backups"

for expected in \
	"hypr/hyprland.lua" \
	"hypr/dms/colors.lua" \
	"hypr/dms/layout.lua" \
	"hypr/dms/binds.lua" \
	"hypr/dms/binds-user.lua" \
	"hypr/dms/outputs.lua" \
	"hypr/dms/cursor.lua" \
	"hypr/dms/windowrules.lua"; do
	if [[ ! -f "${GENERATED}/${expected}" ]]; then
		printf 'dms setup headless did not produce %s\n' "${expected}" >&2
		exit 1
	fi
done

if compgen -G "${GENERATED}/hypr/*.conf" >/dev/null; then
	printf 'Unexpected hyprlang .conf files in the generated configuration\n' >&2
	exit 1
fi

cp -a "${GENERATED}/." "${SKEL}/.config/"
chown -R root:root "${SKEL}"
find "${SKEL}" -type d -exec chmod 0755 {} +
find "${SKEL}" -type f -exec chmod 0644 {} +

# Verify the GTK opt-in gate: without the dank-colors.css import in
# gtk-4.0/gtk.css, isDMSGTKActive() is false and all GTK theming is a no-op.
for gtk_css in "${SKEL}/.config/gtk-3.0/gtk.css" "${SKEL}/.config/gtk-4.0/gtk.css"; do
	if ! grep -q 'dank-colors.css' "${gtk_css}"; then
		printf 'Missing dank-colors.css import in %s\n' "${gtk_css}" >&2
		exit 1
	fi
done

# The packaged Wayland session starts plain `Hyprland`, which autogenerates a
# hyprland.conf and ignores the Lua configuration entirely. Point it at the
# wrapper that passes -c ~/.config/hypr/hyprland.lua instead.
SESSION_DESKTOP="/usr/share/wayland-sessions/hyprland.desktop"
if [[ ! -f "${SESSION_DESKTOP}" ]]; then
	printf 'Expected Wayland session file %s is missing\n' "${SESSION_DESKTOP}" >&2
	exit 1
fi
sed -i 's|^Exec=.*|Exec=/usr/libexec/xit-os/hyprland-session|' "${SESSION_DESKTOP}"
grep -q '^Exec=/usr/libexec/xit-os/hyprland-session$' "${SESSION_DESKTOP}"

systemctl enable xit-os-input-group.service

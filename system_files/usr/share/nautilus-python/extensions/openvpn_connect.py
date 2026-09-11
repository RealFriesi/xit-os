"""Nautilus-Kontextmenü: OpenVPN-Konfiguration in einem Kitty-Terminal verbinden."""

import os
import subprocess
from urllib.parse import unquote, urlparse

import gi

try:
    gi.require_version("Nautilus", "4.0")
except ValueError:
    gi.require_version("Nautilus", "3.0")

from gi.repository import GObject, Nautilus  # noqa: E402

HELPER = "/usr/libexec/xit-openvpn-connect"


def _local_path(file_info):
    uri = file_info.get_uri()
    scheme = urlparse(uri).scheme
    if scheme == "file":
        return unquote(urlparse(uri).path)
    # Samba/GVFS-Mounts sind über den FUSE-Pfad lesbar.
    mapped = file_info.get_location().get_path()
    return mapped


class OpenVPNConnectExtension(GObject.GObject, Nautilus.MenuProvider):
    def _menu_items(self, files):
        if len(files) != 1:
            return []

        file_info = files[0]
        if file_info.is_directory():
            return []
        if not file_info.get_name().lower().endswith(".ovpn"):
            return []
        if not os.path.isfile(HELPER):
            return []

        path = _local_path(file_info)
        if not path:
            return []

        item = Nautilus.MenuItem(
            name="OpenVPNConnectExtension::Connect",
            label="Verbinden (OpenVPN)",
            tip="Konfiguration in einen temporären Ordner kopieren und verbinden",
        )
        item.connect("activate", self._on_activate, path)
        return [item]

    # Nautilus 4.0: (files); Nautilus 3.0: (window, files)
    def get_file_items(self, *args):
        return self._menu_items(args[-1])

    def _on_activate(self, _menu, path):
        subprocess.Popen(
            [
                "kitty",
                "--title",
                "OpenVPN: {}".format(os.path.basename(path)),
                "--",
                HELPER,
                path,
            ],
            start_new_session=True,
        )

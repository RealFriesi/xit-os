"""Nautilus-Kontextmenü: OpenVPN-Konfiguration in Ghostty verbinden."""

import os
import subprocess
from urllib.parse import unquote, urlparse

import gi

gi.require_version("Nautilus", "4.0")

from gi.repository import GObject, Nautilus  # noqa: E402

HELPER = "/usr/libexec/xit-openvpn-connect"


def _config_location(file_info):
    uri = file_info.get_uri()
    scheme = urlparse(uri).scheme
    if scheme == "file":
        return unquote(urlparse(uri).path)
    return uri


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

        location = _config_location(file_info)
        if not location:
            return []

        item = Nautilus.MenuItem(
            name="OpenVPNConnectExtension::Connect",
            label="Verbinden (OpenVPN)",
            tip="Konfiguration in einen temporären Ordner kopieren und verbinden",
        )
        item.connect("activate", self._on_activate, location)
        return [item]

    def get_file_items(self, files):
        return self._menu_items(files)

    def _on_activate(self, _menu, location):
        subprocess.Popen(
            [
                "ghostty",
                "--title",
                "OpenVPN: {}".format(os.path.basename(location)),
                "-e",
                HELPER,
                location,
            ],
            start_new_session=True,
        )

# XIT OS

XIT OS ist ein persönliches Linux-System für den Arbeitsalltag. Es basiert auf Fedora Bootc und bündelt eine verlässliche grafische Arbeitsumgebung mit ausgewählten Anwendungen, Netzwerkfunktionen und Werkzeugen für Entwicklung und Administration.

Das System ist für den persönlichen Einsatz gedacht und wird als unveränderliches Bootc-Image gepflegt.

## Funktionen

- GNOME als grafische Arbeitsumgebung
- Firefox, Nautilus, Kitty, Fish und Starship für die tägliche Arbeit
- AnyDesk für den Fernzugriff
- Distrobox und Podman für isolierte Arbeits- und Entwicklungsumgebungen
- OpenVPN mit Nautilus-Kontextmenü für `.ovpn`-Dateien
- Bitwarden, Flatseal, Papers, Loupe, Bazaar und weitere ausgewählte Flatpaks
- FiraCode Nerd Font sowie deutsch/englische Sprachunterstützung
- Automatisches Einbinden von Medien und Unterstützung für SMB-, MTP-, Archiv- und GPhoto-Geräte

## OpenVPN im Dateimanager

Eine `.ovpn`-Datei kann in Nautilus über das Kontextmenü mit **Verbinden (OpenVPN)** gestartet werden. Die Konfigurationsdatei und die Dateien aus ihrem Ordner werden dafür in ein geschütztes temporäres Verzeichnis kopiert. So funktionieren auch Konfigurationen von Samba- oder GVFS-Mounts.

Die Verbindung läuft in Kitty und kann dort mit `Strg+C` beendet werden.

## Eigenes Bootc-Image erstellen

Wer selbst ein auf Fedora oder Universal Blue basierendes Bootc-Image erstellen möchte, findet im offiziellen [Universal Blue Image Template](https://github.com/ublue-os/image-template) eine geeignete Grundlage mit Dokumentation und Build-Workflow.

## Sicherheit

Zugangsdaten, VPN-Konfigurationen und private Schlüssel gehören nicht in dieses Repository. Änderungen am System werden über ein neues Image ausgerollt und nicht dauerhaft manuell im laufenden Basissystem vorgenommen.

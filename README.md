# XIT OS

XIT OS ist ein persönliches Linux-System für den Arbeitsalltag. Es basiert auf Fedora Bootc und bündelt eine verlässliche grafische Arbeitsumgebung mit ausgewählten Anwendungen, Netzwerkfunktionen und Werkzeugen für Entwicklung und Administration.

Das System ist für den persönlichen Einsatz gedacht und wird als unveränderliches Bootc-Image gepflegt.

## Funktionen

- GNOME als grafische Arbeitsumgebung
- Firefox, Nautilus, Ghostty, Fish und Starship für die tägliche Arbeit
- AnyDesk für den Fernzugriff
- Distrobox und Podman für isolierte Arbeits- und Entwicklungsumgebungen
- OpenVPN mit Nautilus-Kontextmenü für `.ovpn`-Dateien
- Bitwarden, Flatseal, Papers, Loupe, Bazaar und weitere ausgewählte Flatpaks
- FiraCode Nerd Font sowie deutsch/englische Sprachunterstützung
- Automatisches Einbinden von Medien und Unterstützung für SMB-, MTP-, Archiv- und GPhoto-Geräte

## OpenVPN im Dateimanager

Eine `.ovpn`-Datei kann in Nautilus über das Kontextmenü mit **Mit VPN verbinden** aktiviert werden. Die Konfiguration wird dafür in ein temporäres Verzeichnis kopiert und als flüchtige NetworkManager-Verbindung aktiviert. So funktionieren auch Konfigurationen von Samba- oder GVFS-Mounts. Werden Zugangsdaten benötigt, fragt ein Zenity-Dialog danach und kann sie optional im Secret Service speichern.

Das Kontextmenü stammt aus der Rust-Nautilus-Extension [nautilus-ovpn](https://github.com/RealFriesi/nautilus-ovpn), deren `.so`-Release beim Image-Build heruntergeladen wird.

## Eigenes Bootc-Image erstellen

Wer selbst ein auf Fedora oder Universal Blue basierendes Bootc-Image erstellen möchte, findet im offiziellen [Universal Blue Image Template](https://github.com/ublue-os/image-template) eine geeignete Grundlage mit Dokumentation und Build-Workflow.

## Sicherheit

Zugangsdaten, VPN-Konfigurationen und private Schlüssel gehören nicht in dieses Repository. Änderungen am System werden über ein neues Image ausgerollt und nicht dauerhaft manuell im laufenden Basissystem vorgenommen.

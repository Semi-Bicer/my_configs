#!/bin/sh
# Bu repodaki ayarları ~/.config altına geri yükler. Mevcut dosyaları .bak-<tarih> olarak yedekler.
set -e
D="$(cd "$(dirname "$0")" && pwd)"; T=$(date +%Y%m%d-%H%M%S)
put() { # kaynak hedef
  mkdir -p "$(dirname "$2")"
  [ -e "$2" ] && cp "$2" "$2.bak-$T"
  cp "$1" "$2"
}
put "$D/kitty/kitty.conf"          ~/.config/kitty/kitty.conf
put "$D/kitty/current-theme.conf"  ~/.config/kitty/current-theme.conf
for f in kwinrc kwinrulesrc krunnerrc kglobalshortcutsrc plasmashellrc kdeglobals plasma-org.kde.plasma.desktop-appletsrc; do
  put "$D/kde/$f" ~/.config/$f
done
put "$D/color-schemes/ArgonautNord.colors" ~/.local/share/color-schemes/ArgonautNord.colors
put "$D/plasma-workspace-env/qml-user.sh"  ~/.config/plasma-workspace/env/qml-user.sh
chmod +x ~/.config/plasma-workspace/env/qml-user.sh
echo "Tamam. Oturumu kapatip acin (veya: kwin_wayland --replace degil, sadece logout/login)."
echo "Eksik parcalar icin README.md'deki 'Kurulum' bolumune bakin (Polonium, Virtual Desktop Bar)."

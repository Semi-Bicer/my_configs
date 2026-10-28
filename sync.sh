#!/bin/sh
# Canlı ayarları repoya kopyalar, commit atar ve push eder.
# Kullanım: ./sync.sh ["commit mesajı"]   (mesaj yoksa: "Güncelleme: YYYY-MM-DD HH:MM")
set -e
D="$(cd "$(dirname "$0")" && pwd)"; C=~/.config
cd "$D"

cp "$C/kitty/kitty.conf" "$C/kitty/current-theme.conf" kitty/
for f in kwinrc kwinrulesrc krunnerrc kglobalshortcutsrc plasmashellrc kdeglobals; do
  cp "$C/$f" kde/
done
# Masaüstü dosya adları kişisel: panel dosyasından çıkar
grep -vE '^(changedPositions|positions)=' "$C/plasma-org.kde.plasma.desktop-appletsrc" > kde/plasma-org.kde.plasma.desktop-appletsrc
cp ~/.local/share/color-schemes/ArgonautNord.colors color-schemes/
cp "$C/plasma-workspace/env/qml-user.sh" plasma-workspace-env/

git add -A
if git diff --cached --quiet; then
  echo "Değişiklik yok."; exit 0
fi

MSG="${1:-Güncelleme: $(date '+%Y-%m-%d %H:%M')}"
git diff --cached --stat
git commit -q -m "$MSG" -m "Değişen: $(git diff --cached --name-only | tr '\n' ' ')"
git push -q
echo "Gönderildi: $MSG"

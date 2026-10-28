# my_configs

CachyOS + KDE Plasma 6 (Wayland) rice ayarlarım: Argonaut renkleri, Nord yuvarlak şekiller, üstte tek panel, 8 masaüstü, Polonium ile karışık (tiling + serbest) pencere yerleşimi.

## İçerik
| Yol | Ne yapar |
|---|---|
| `kitty/` | kitty ayarı + Argonaut teması (şeffaf, `hide_window_decorations`) |
| `kde/kwinrc` | 8 masaüstü, Polonium, karartma efekti (diminactive), Godot/Unreal/Unity'yi tiling dışı bırakan liste |
| `kde/kwinrulesrc` | Tüm pencerelerde başlık çubuğunu kaldıran kural (`argonaut-noborder`) |
| `kde/kglobalshortcutsrc` | Meta+1..8 geçiş, Meta+Shift+1..8 pencere taşıma, Meta+Enter = KRunner, Polonium kısayolları |
| `kde/krunnerrc` | KRunner ekranın ortasında |
| `kde/plasma-org.kde.plasma.desktop-appletsrc`, `plasmashellrc` | Üst panel (Virtual Desktop Bar, CPU/RAM, saat, tepsi). Masaüstü dosya konumları kasıtlı olarak çıkarıldı |
| `color-schemes/ArgonautNord.colors` | Özel renk şeması |
| `plasma-workspace-env/qml-user.sh` | `~/.local` altındaki QML eklentilerini Plasma'ya tanıtır |

## Kurulum (sıfırdan)
1. Paketler: `sudo pacman -S --needed kitty cmake extra-cmake-modules vulkan-headers git`
2. Plasma teması: CachyOS'un `CachyOS-Nord-round` teması (CachyOS ile gelir).
3. Polonium (tiling): https://github.com/zeroxoneafour/polonium sürümünü indirip `kpackagetool6 -t KWin/Script -i polonium.kwinscript`
4. Virtual Desktop Bar: https://github.com/lenonk/virtual-desktop-bar (v1.0.2) kaynağını indir, sonra
   `cmake -S src -B build -DCMAKE_INSTALL_PREFIX=$HOME/.local -DCMAKE_BUILD_TYPE=Release && cmake --build build -j && cmake --install build`
   (AUR bu ağda engelli olduğu için kaynaktan derleniyor.)
5. `./install.sh` çalıştır, sonra oturumu kapatıp aç.
6. Masaüstü sayısı config'ten değil, D-Bus ile oluşur: `qdbus6 org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.createDesktop <konum> <isim>`

## Notlar
- Brave gibi tarayıcılar başlık çubuğunu kendileri çizer: sekme çubuğuna sağ tık → "Sistem başlık çubuğunu ve kenarlıklarını kullan".
- `NoPlugin=true` (dekorasyonu kapatma) kitty'yi kendi başlık çubuğunu çizmeye zorlar, o yüzden pencere kuralı kullanıldı.
- Polonium ayarlarını yalnızca başlangıçta okur: `kwinrc` düzenlendikten sonra `poloniumEnabled` değerini kapatıp açmak gerekir.

#!/bin/bash
set -e

echo "=================================================="
echo "  niri-dots installer"
echo "=================================================="
echo

# ---------------------------------------------------------------
# 1. paru (AUR helper)
# ---------------------------------------------------------------
if ! command -v paru &> /dev/null; then
    echo "==> Installing paru..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/paru
else
    echo "==> paru already installed, skipping"
fi

# ---------------------------------------------------------------
# 2. Core packages
# ---------------------------------------------------------------
echo "==> Installing core packages..."
paru -S --needed --noconfirm \
    niri \
    waybar \
    ghostty \
    swaync \
    rofi \
    fastfetch \
    thunar tumbler ffmpegthumbnailer poppler-glib libgsf \
    starship \
    yazi \
    cava \
    qt6ct \
    strawberry \
    grim slurp \
    playerctl \
    brightnessctl \
    pipewire pipewire-pulse pipewire-alsa wireplumber \
    xdg-desktop-portal-gtk xdg-desktop-portal-gnome \
    xwaylandvideobridge \
    wob \
    github-cli \
    python \
    bc

# ---------------------------------------------------------------
# 3. Wallpaper daemon + wallpaper picker
# ---------------------------------------------------------------
echo "==> Installing wallpaper tools..."
paru -S --needed --noconfirm awww waypaper

# ---------------------------------------------------------------
# 4. Fonts
# ---------------------------------------------------------------
echo "==> Installing fonts..."
paru -S --needed --noconfirm \
    ttf-jetbrains-mono-nerd \
    otf-lexend

# ---------------------------------------------------------------
# 5. Theming (GTK theme, icons, cursor)
# ---------------------------------------------------------------
echo "==> Installing GTK theme, icons, cursor theme..."
paru -S --needed --noconfirm \
    adw-gtk-theme \
    papirus-icon-theme \
    bibata-cursor-theme

# ---------------------------------------------------------------
# 6. Copy configs
# ---------------------------------------------------------------
echo "==> Copying config files to ~/.config/..."
mkdir -p ~/.config ~/.local/bin
cp -r config/* ~/.config/
cp -r local/bin/* ~/.local/bin/
chmod +x ~/.local/bin/*.sh 2>/dev/null || true
cp bashrc ~/.bashrc

echo
echo "=================================================="
echo "  Automated part done. MANUAL steps still needed:"
echo "=================================================="
echo
echo "1. Bootloader (Visor) — NOT installed automatically."
echo "   Setting up a boot manager touches your EFI partition;"
echo "   doing this blindly on a new machine can leave it unbootable."
echo "   See: https://github.com/facundoolano/visor"
echo
echo "2. SDDM 'silent' theme — install manually and set:"
echo "     /etc/sddm.conf -> [Theme] Current=silent"
echo
echo "3. Absolute paths — search configs for '/home/felip' and"
echo "   replace with your own home directory:"
echo "     grep -rl '/home/felip' ~/.config"
echo
echo "4. Spicetify (Spotify theming) has its own separate installer:"
echo "   https://spicetify.app/docs/getting-started"
echo
echo "5. Log out and back into a niri session for everything to apply."
echo "=================================================="

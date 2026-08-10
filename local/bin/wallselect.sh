#!/bin/bash
WALL_DIR="$HOME/wallpapers/pictures"

list_walls() {
    cd "$WALL_DIR" || exit
    for file in *.jpg *.jpeg *.png *.gif; do
        [[ -e "$file" ]] || continue
        echo -en "$file\0icon\x1f$WALL_DIR/$file\n"
    done
}

set_wallpaper() {
    local wall="$1"
    awww img -n "wallpaper" "$wall" \
        --transition-type random \
        --transition-step 90 \
        --transition-fps 60

    mkdir -p "$WALL_DIR/temp"
    magick "$wall" -blur 0x15 "$WALL_DIR/temp/backdrop.jpg"
    awww img -n "backdrop" "$WALL_DIR/temp/backdrop.jpg"
}

CHOICE=$(list_walls | rofi -dmenu -i -p "Wallpaper" -theme-str "listview { columns: 4; lines: 3; spacing: 8px; } element { orientation: vertical; padding: 8px; } element-icon { size: 200px; horizontal-align: 0.5; }")

if [ -n "$CHOICE" ]; then
    WALL="$WALL_DIR/$CHOICE"
    set_wallpaper "$WALL"

    ACCENT=$(python3 -c '
from colorthief import ColorThief
import sys
def brightness(c): return sum(v*v for v in c)
colors = ColorThief(sys.argv[1]).get_palette(color_count=5)
brightest = max(colors, key=brightness)
print("#%02x%02x%02x" % brightest)
' "$WALL")

    r=$(printf "%d" 0x${ACCENT:1:2})
    g=$(printf "%d" 0x${ACCENT:3:2})
    b=$(printf "%d" 0x${ACCENT:5:2})
    if [ $((r + g + b)) -lt 180 ]; then
        ACCENT="#6b8cad"
    fi

    ~/.local/bin/apply-accent.sh "$ACCENT"
fi

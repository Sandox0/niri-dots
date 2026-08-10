#!/bin/bash
ACCENT="$1"

if ! [[ "$ACCENT" =~ ^#[0-9a-fA-F]{6}$ ]]; then
    ACCENT="#6b8cad"
fi

HEX="${ACCENT#\#}"

sed -i \
    -e "s/^cursor-color = .*/cursor-color = ${HEX}/" \
    -e "s/^selection-background = .*/selection-background = ${HEX}/" \
    -e "s/^palette = 4=.*/palette = 4=#${HEX}/" \
    -e "s/^palette = 12=.*/palette = 12=#${HEX}/" \
    ~/.config/ghostty/config

sed -i \
    -e "s/active-color \"#[0-9a-fA-F]\{6\}[0-9a-fA-F]\{0,2\}\"/active-color \"${ACCENT}66\"/" \
    -e "s/inactive-color \"#[0-9a-fA-F]\{6\}[0-9a-fA-F]\{0,2\}\"/inactive-color \"${ACCENT}33\"/" \
    ~/.config/niri/config.kdl

niri validate && echo "Acento aplicado: $ACCENT"

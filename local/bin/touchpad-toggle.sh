#!/bin/bash
CONFIG="$HOME/.config/niri/config.kdl"

RESULT=$(python3 << PYEOF
path = "$CONFIG"
with open(path) as f:
    content = f.read()

marker = "touchpad {\n        off\n"
if marker in content:
    content = content.replace(marker, "touchpad {\n")
    print("activado")
else:
    content = content.replace("touchpad {\n", "touchpad {\n        off\n", 1)
    print("desactivado")

with open(path, "w") as f:
    f.write(content)
PYEOF
)

if [ "$RESULT" = "activado" ]; then
  notify-send -a "niri" -i input-touchpad "Touchpad enabled" -t 1500
else
  notify-send -a "niri" -i input-touchpad "Touchpad disabled" -t 1500
fi

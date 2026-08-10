#!/bin/bash
WALLPAPER="$1"
BLURRED="/tmp/niri-backdrop-blur.jpg"

magick "$WALLPAPER" -resize 20% -blur 0x6 -resize 500% "$BLURRED" &

awww img --namespace wallpaper \
    --transition-type grow \
    --transition-duration 1 \
    --transition-fps 60 \
    "$WALLPAPER"

wait
awww img --namespace backdrop --transition-type simple "$BLURRED"

#!/bin/bash
capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

if [ "$status" = "Charging" ]; then
    echo "󱐋 $capacity%"
elif [ "$status" = "Full" ]; then
    echo " $capacity%"
elif [ $capacity -le 20 ]; then
    echo " $capacity%"
elif [ $capacity -le 40 ]; then
    echo " $capacity%"
elif [ $capacity -le 60 ]; then
    echo " $capacity%"
elif [ $capacity -le 80 ]; then
    echo " $capacity%"
else
    echo " $capacity%"
fi


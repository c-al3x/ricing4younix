#!/bin/bash
picom --config ~/.config/picom/picom.conf &
sxhkd -c ~/.config/sxhkd/sxhkdrc &
~/.fehbg &

while true; do
    ~/Documents/random/scripts/dwmstatusbar.sh 0
    sleep 60
done &

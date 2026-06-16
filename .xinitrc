#!/bin/sh
xrandr --rate 165.00

./scripts/wallpaper_x11.sh &
xcompmgr &
xrdb -merge ./.Xresources
xset r rate 370 45
dwmblocks &

export XMODIFIERS=@im=fcitx
fcitx5 -d

exec dwm

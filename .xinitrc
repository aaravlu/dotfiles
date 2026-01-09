./scripts/wallpaper_x11.sh &


#!/bin/sh
dwmblocks &
exec dwm
fcitx5 -d
xcompmgr &
xrandr --output HDMI-A-1 --mode 3840x2160
xrdb -merge ./.Xresources
xset r rate 370 45

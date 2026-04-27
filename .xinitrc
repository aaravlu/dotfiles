#!/bin/sh
xrandr --rate 165.00

./scripts/wallpaper_x11.sh &
xcompmgr &
xrdb -merge ./.Xresources
xset r rate 370 45
dwmblocks &

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=fcitx
fcitx5 -d

exec dwm

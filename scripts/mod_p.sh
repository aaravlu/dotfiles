#!/bin/sh
[ -n "$WAYLAND_DISPLAY" ] && menu="wmenu -l 3" || menu="dmenu -l 3"

choice=$(printf "Logout\nReboot\nShutdown" | eval $menu)

case "$choice" in
    "Logout")
        loginctl terminate-session $XDG_SESSION_ID
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
esac

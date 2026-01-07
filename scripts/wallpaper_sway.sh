#!/bin/sh
set_wallpaper() {
  pkill swaybg 2>/dev/null
  swaybg -i ~/Pictures/today_bing.jpg
}

swaybg -i ~/Pictures/today_bing.jpg &
wallpaper && set_wallpaper

#!/bin/sh
restart_swaybg() {
  pkill swaybg 2>/dev/null
  swaybg -i ~/Pictures/today_bing.jpg
}

swaybg -i ~/Pictures/today_bing.jpg &
wallpaper && restart_swaybg

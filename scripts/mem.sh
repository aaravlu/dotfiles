#!/bin/sh
free -b | awk '/Mem:/ {printf "%.2f Gi", $3/1024/1024/1024}'

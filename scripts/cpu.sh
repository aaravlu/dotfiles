#!/bin/sh
awk '{sum+=$1; n++} END {if (n>0) printf "%.2f Gh", sum/n/1e6}' /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq

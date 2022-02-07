#!/bin/bash

MOUSE="/org/freedesktop/UPower/devices/mouse_hidpp_battery_0"

[[ "$1" == "memory" ]] && echo " `free | grep Mem | awk '{ printf("%.0f%\n", $3/$2 * 100.0) }'` " && exit
[[ "$1" == "volume" ]] && echo " `pamixer --get-volume`% " && exit
[[ "$1" == "mic" ]] && echo `amixer -D pulse get Capture | grep 'Mono:' | awk '{ print $4 }' | sed -E 's/\[|\]|%//g'` && exit
[[ "$1" == "date" ]] && echo " `date '+%D %H:%M'` " && exitn
[[ "$1" == "cpu" ]] && echo " $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} {sub("\\..*", "", usage);} END {print usage "%"}') " && exit
[[ "$1" == "mouse_battery" ]] && echo " $(upower -i $MOUSE | grep percentage | awk '{print $2}') " && exit
if [[ "$1" == "mpd" ]];then
    [[ "`mpc | wc -l`" == "3" ]] && echo " `mpc 2>/dev/null | head -n1` " || echo " No Music Playing " && exit
fi
[[ "$1" == "music_control_eww" ]] && [[ `mpc status | grep paused` ]] && echo "喇" && exit || echo "" && exit
[[ "$1" == "music_control" ]] && [[ `mpc status | grep paused` ]] && echo "%{T4}喇%{T-}" && exit || echo "%{T4}%{T-}" && exit

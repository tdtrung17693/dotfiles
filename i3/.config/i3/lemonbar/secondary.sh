#!/bin/env bash
. ~/.config/i3/lemonbar/colors

FONT1="TamzenForPowerline:size=11"
FONT2="Unifont:size=11"
FONT3="Siji:size=11"

PW=800
PH=30
PX=$(((1920+(1920-800)/2)))
PY=10
PD=10 # padding
PD_H=$((PD+PH))

calendar=$(date "+%d %b %Y")
date=$(date "+%H:%M")
timestr="%{c}%{F$CYAN}\ue266 %{F-}${calendar}%{F$CYAN} \ue015 %{F-}${date}"

while true; do
    echo -e $timestr
    sleep 0.2
done | lemonbar -g ${PW}x${PH}+${PX}+${PY} -o -1 -f "$FONT1" -o 0 -f "$FONT2" -o -2 -f "$FONT3" -B "$BG" -F "$FG" -p -d -n 'secondary' | zsh


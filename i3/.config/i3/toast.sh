#!/bin/zsh

CD="/home/tdtrung17693/.Xdefaults"

BG=$(cat ${CD} | grep -i background | tail -c 8)
FG=$(cat ${CD} | grep -i foreground | tail -c 8)
 
BLACK=$(cat ${CD} | grep -i 'color8 :' | tail -c 8)
RED=$(cat ${CD} | grep -i 'color9 :' | tail -c 8)
GREEN=$(cat ${CD} | grep -i 'color10:' | tail -c 8)
YELLOW=$(cat ${CD} | grep -i 'color11:' | tail -c 8)
BLUE=$(cat ${CD} | grep -i 'color12:' | tail -c 8)
MAGENTA=$(cat ${CD} | grep -i 'color13:' | tail -c 8)
CYAN=$(cat ${CD} | grep -i 'color14:' | tail -c 8)
WHITE=$(cat ${CD} | grep -i 'color15:' | tail -c 8)

VW=1920
VH=1080

PW=500
PH=40
X=$((VW/2-PW/2))
Y=$((VH-PH-20))

FONT="Source Code Pro-12"

msg=$1

while :; do 
    echo %{c}$msg
    sleep 2s
    break
done | lemonbar -g ${PW}x${PH}+${X}+${Y} -f "${FONT}" -B "${BG}" -F "${FG}" -d



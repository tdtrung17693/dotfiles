#!/bin/zsh

PW=1920
PH=1080
PX=0 
PY=0

while :; do
    echo -e "%{c}%{A:shutdown -P now:}SHUTDOWN%{A} | %{A:reboot:}REBOOT%{A} | %{A:i3-msg exit:}LOGOUT%{A} | %{A:xdotool search --name PowerPanel windowkill && systemctl suspend:%}SUSPEND%{A} | %{A:xdotool search --name PowerPanel windowkill:}EXIT%{A}" 
    sleep 0.2s
done | lemonbar -d -g ${PW}x${PH}+${PX}+${PY} -B "#111" -F "#fff" -f "TamzenForPowerline-13" -n PowerPanel | zsh

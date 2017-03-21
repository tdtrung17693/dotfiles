#!/bin/zsh

# Kill other instance
if [ $(pgrep -cx $(basename $0)) -gt 1 ]; then
    printf "%s\n" "Running" >&2
    exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

# import colors
. ~/.config/i3/lemonbar/colors

# Fonts
#FONT1="Source Han Sans JP Regular:size=11"
FONT1="TamzenForPowerline:size=11"
FONT2="Unifont:size=11"
FONT3="Siji:size=11"

# Panel
PW=1920
PH=25
PX=0
PY=0

# mpd
host="localhost"
port="6601"

#Actions
VOLT="amixer sset Master toggle"
VOLU="amixer sset Master 5%+"
VOLD="amixer sset Master 5%-"
TMUS="mpc --host ${host} --port ${port} toggle"
NMUS="mpc --host ${host} --port ${port} next"
OPENMUSIC="termite -e 'ncmpcpp --host ${host} --port ${port}' -t ncmpcpp &"

music() {
	state=$(mpc --host=$host --port=$port status | grep -E "(playing|paused)" -o)

    if [[ $state == "playing" ]]; then
		icon='\ue09b'
	else
		icon='\ue09a'
	fi

    if [[ -z "$state" ]]; then
        duration="00:00/00:00"
    else
    	duration=$(mpc --host=$host --port=$port status | grep '\[playing\|paused' | awk '/\[.*\]/{printf("%s"), $3}' | xargs)
    fi

    playback="%{B$CYAN}%{F$BG}  %{A:mpc --host=$host --port=$port prev:}\ue097%{A}  %{A:mpc --host=$host --port=$port toggle:}${icon}%{A}  %{A:mpc --host=$host --port=$port next:}\ue09d%{A}  %{B- F-}"
	echo -e "${playback}   ${duration}  |  %{F$CYAN}\ue05c%{F-}"
}



net(){
	ping=$(pn=$(timeout .8 ping 8.8.8.8 -c 1 -s 24 | sed '2!d;s/.*time=\([0-9]*\).*/\1/'); if [ -z $pn ] ; then echo "No Connection"; else echo "${pn}ms"; fi)

	echo -e "%{F$GREEN}\ue0f0 ${ping}"
}


clock(){
    calendar=$(date "+%d %b %Y")
    dat=$(date "+%H:%M")
	echo -e "%{F$CYAN}\ue266 %{F-}${calendar}%{F$CYAN} \ue015 %{F-}${dat}"
}

vol(){
    vol=$(amixer get Master | grep Mono | sed -nr 'N;s/^.*\[([0-9]+)%\].*/\1/p')

    if [[ $(amixer get 'Master' | grep -c off) = 0 ]]; then
        if [[ $vol = 0 ]]
        then
        icon="\ue204"
	    else
		icon="\ue203"
	    fi
    else
        icon="\ue202"
    fi

    echo -e "%{F$CYAN} ${icon} %{F-}${vol}"
}

temp() {
    temp=$(tlp-stat --temp | grep temp | sed -r 's/[^0-9]*([0-9]+).*/\1/')
	echo -e "%{F$CYAN} \ue1c1 %{F-}${temp}\u00b0C"
}

cpu() {
    cpu=$(ps -eo pcpu |grep -vE '^\s*(0.0|%CPU)' |sed -n '1h;$!H;$g;s/\n/ +/gp' | bc)
	echo -e "%{F$CYAN} \ue1d7 %{F-}${cpu}"
}

ram() {
    ram=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')
	echo -e "%{F$CYAN} \ue021 %{F-}${ram}"
}

pow() {
    onAC=$(cat /sys/class/power_supply/ADP1/online)
    lvl=$(echo "$(cat /sys/class/power_supply/BAT1/charge_now)*100/$(cat /sys/class/power_supply/BAT1/charge_full)" | bc -l | sed -nr 's/^([0-9][^.]*).*/\1/p')
	stat=$(cat /sys/class/power_supply/BAT1/status)

    if [[ $onAC == 1 ]]
    then
        pow="\ue239"
	elif [[ $stat == "Charging" ]]
	then
		pow="\uE1A3"
	elif [[ $lvl > 20 ]]
	then
		pow="\uE1A4"
	else
		pow="\uE19C"
	fi

	echo -e "%{F$CYAN}${pow}%{F-} ${lvl}%"
}

zscroll -d 0.2 -n -u -M "mpc --host $host --port $port status" -m "playing" -s 1 \
-m "paused" -s 0 "mpc --host $host --port $port current" |\

while true; do
	read -t 0.1 line

	echo -e "$(music)%{A:$OPENMUSIC:} ${line} %{A} %{c}$(cpu) $(temp) $(ram)  $(pow)%{r}$(net) %{A:$VOLT:}%{A4:$VOLU:}%{A5:$VOLD:}$(vol)%{A}%{A}%{A}  $(clock)  %{B#373A3B}%{F$FG}%{A:$HOME/.config/i3/lemonbar/pop_panel.sh:} \ue00d%{A} %{B- F-}"

	sleep 0.1
done | \
lemonbar -g ${PW}x${PH}+${PX}+${PY} -o -1 -f "$FONT1" -o 0 -f "$FONT2" -o -2 -f "$FONT3" -B "$BG" -F "$FG" -p | zsh

wait

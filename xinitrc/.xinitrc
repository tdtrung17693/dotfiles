# IBUS
#######################

ibus-daemon -drx

# MPD
#######################

mpd

# URXVTD
#######################

urxvtd -o -f -q &

# COMPTON
#######################

compton --config ~/.compton/config --logpath /tmp/compton &

# DUNST
#######################

dunst 2>>/tmp/dunst.log &

# X's STUFF
#######################

xset +fp /home/tdtrung17693/.fonts
xset +fp /home/tdtrung17693/.fonts/tamzen/bdf
xset fp rehash

xset -b

# detect external monitor
EXMONITOR=DisplayPort-2

if [ $(xrandr | grep -c ' connected ') -eq 2 ]; then
	xrandr --output $EXMONITOR --auto --primary --output LVDS --right-of $EXMONITOR
else
	xrandr --output LVDS --auto --primary
fi
	

xrdb -load ~/.Xdefaults


# START SESSION
#######################
exec i3

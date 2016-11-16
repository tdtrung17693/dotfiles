#!/bin/evn bash
# IBUS
#######################

#ibus-daemon -drx
fcitx -d
# MPD
#######################

mpd

# COMPTON
#######################

compton --config ~/.compton/config --logpath /tmp/compton &

# DUNST
#######################

dunst 2>>/tmp/dunst.log &

# X's STUFF
#######################

xset +fp /home/tdtrung17693/.fonts
xset fp rehash

xset -b

xinput set-prop 13 "Device Enabled" 0
# detect external monitor
EXMONITOR=HDMI2
INMONITOR=eDP1

if [ $(xrandr | grep -c ' connected ') -eq 2 ]; then
    xrandr --output $EXMONITOR --auto --primary --output $INMONITOR --right-of $EXMONITOR --gamma 0.9:0.82:0.8 --brightness 1.0
    # Set wallpaper
    feh --bg-max --no-xinerama ~/Pictures/pjimage.jpg
else
  	xrandr --output $INMONITOR --auto --primary --gamma 0.9:0.82:0.8 --brightness 1.0
    # Set wallpaper
    feh --bg-fill ~/Pictures/photo-1464491965784-a12f0f70642b.jpg
fi

xrdb -load ~/.Xdefaults

# START SESSION
#######################
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

keychain --confhost
[ -f ~/.keychain/$HOSTNAME-sh ] && . ~/.keychain/$HOSTNAME-sh 2>/dev/null
[ -f ~/.keychain/$HOSTNAME-sh-gpg ] && . ~/.keychain/$HOSTNAME-sh-gpg 2>/dev/null

exec i3

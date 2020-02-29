#!/bin/env bash

# DEFAULT TEXT EDITOR
#######################
export EDITOR='vim'
export VISUAL='vim'

# IBUS
#######################

ibus-daemon -drx
#fcitx -d


# MPD
#######################

# mopidy &
# mpd &


# JetBrains License Server
# ./IntelliJIDEALicenseServer_linux_amd64  -p 1337 -u tdtrung17693 &
# autossh -M 0 -R jetserv176:80:localhost:1337 serveo.net &

# env XDG_CURRENT_DESKTOP=GNOME /usr/libexec/gsd-rfkill &

export GTK_CSD=0
#export LD_PRELOAD=/usr/lib64/libgtk3-nocsd.so.0
export WM=i3
case $WM in
    i3) exec i3 ;;
    electron) exec ./photo-attendance-client-linux-x64/photo-attendance-client ;;
    *) exec i3 ;;
esac

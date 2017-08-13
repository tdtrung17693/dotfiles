#!/bin/env bash
EXMONITOR=DisplayPort-2

if [ $(xrandr | grep -c ' connected ') -eq 2 ]; then
    i3-msg "workspace 1 output ${EXMONITOR} \n\
            workspace 2 output ${EXMONITOR} \n\
            workspace 3 output ${EXMONITOR} \n\
            workspace 4 output ${EXMONITOR} \n\
            workspace 5 output ${EXMONITOR} \n\
            workspace 6 output LVDS \n\
            workspace 7 output LVDS \n\
            workspace 8 output LVDS \n\
            workspace 9 output LVDS \n\
            workspace 10 output LVDS"
else
    i3-msg "workspace 1 output LVDS \n\
            workspace 2 output LVDS \n\
            workspace 3 output LVDS \n\
            workspace 4 output LVDS \n\
            workspace 5 output LVDS \n\
            workspace 6 output LVDS \n\
            workspace 7 output LVDS \n\
            workspace 8 output LVDS \n\
            workspace 9 output LVDS \n\
            workspace 10 output LVDS"
fi

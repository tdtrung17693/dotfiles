#!/usr/bin/env bash

SDIR="$HOME/.config/polybar/grayblocks/scripts"

get_sink_names() {
  pactl list sinks | grep Description | awk -F ":" '{ print $2 }' | sed -e "s/^[[:space:]]*//"
}

get_sink_ids() {
  pactl list sinks  | grep Name | awk -F ":" '{ print $2 }' | sed -e 's/^[[:space:]]*//'
}


# Launch Rofi
MENU="$(echo "$(get_sink_names)" | rofi -no-config -no-lazy-grab -format "i" -sep "\n" -dmenu -i \
-theme $SDIR/rofi/styles.rasi)"

sink_ids=("$(get_sink_ids)")
sink_ids_array=($sink_ids)

if [[ -z $MENU ]]; then
  exit 0
fi

selected_id=${sink_ids_array[MENU]}

pactl set-default-sink $selected_id

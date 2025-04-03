#! /bin/bash

# current date and time
current_date=$(date +%Y-%m-%d)
current_hour=$(date +%H)

# Define theme paths - you'll need to create these theme files
LIGHT_THEME="$HOME/.config/kitty/themes/light.conf"
DARK_THEME="$HOME/.config/kitty/themes/dark.conf"

# Function to apply theme
apply_theme() {
    local theme_file=$1
    if [ -f "$theme_file" ]; then
        kitty @ set-colors --all "$theme_file"
    else
        echo "Theme file not found: $theme_file"
        exit 1
    fi
}

# Apply theme based on time
# Light theme from 6 AM to 6 PM
if [ "$current_hour" -ge 6 ] && [ "$current_hour" -lt 18 ]; then
    apply_theme "$LIGHT_THEME"
else
    apply_theme "$DARK_THEME"
fi





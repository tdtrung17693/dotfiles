#!/bin/sh

maim -u ~/Pictures/screenshots/$(date +%Y-%m-%d-%HH-%MM-%SS).png && notify-send 'Scrot' 'Screenshot saved to ~/Pictures/screenshots/'

#!/bin/bash

killall waybar && killall swaync
waybar -c ~/.config/waybar/themes/abajoclasica/config -s ~/.config/waybar/themes/abajoclasica/style.css &
swaync -c ~/.config/sncabajo/config.json -s ~/.config/sncabajo/style.css &
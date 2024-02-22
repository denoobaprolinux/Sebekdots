#!/bin/bash

nwg-menu -va bottom -ml 10 -cmd-lock "gtklock -i -b $HOME/.cache/current_wallpaper.jpg" -cmd-logout "hyprctl dispatch exit" -cmd-restart "reboot" -cmd-shutdown "poweroff" -fm "nautilus" -d -isl 20 -iss 10

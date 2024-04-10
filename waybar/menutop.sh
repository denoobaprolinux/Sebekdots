#!/bin/bash

nwg-menu -va top -ml 10 -cmd-lock "hyprlock" -cmd-logout "hyprctl dispatch exit" -cmd-restart "reboot" -cmd-shutdown "poweroff" -fm "nautilus" -d -isl 20 -iss 10

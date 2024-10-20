#!/bin/bash

nwg-menu -va bottom -ml 5 -mb 5 -cmd-lock "hyprlock" -cmd-logout "hyprctl dispatch exit" -cmd-restart "reboot" -cmd-shutdown "poweroff" -fm "nautilus" -d -isl 20 -iss 10

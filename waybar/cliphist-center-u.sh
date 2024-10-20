#!/bin/bash

case $1 in
    d) cliphist list | rofi -dmenu -replace -config ~/.config/rofi/config-cliphist-center-u.rasi | cliphist delete
       ;;

    w) if [ `echo -e "Borrar" | rofi -dmenu -config ~/.config/rofi/config-short-center-u.rasi` == "Borrar" ] ; then
            cliphist wipe
       fi
       ;;

    *) cliphist list | rofi -dmenu -config ~/.config/rofi/config-cliphist-center-u.rasi -display-columns 2 | cliphist decode | wl-copy
       ;;
esac



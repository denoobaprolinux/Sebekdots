#!/bin/bash

# -----------------------------------------------------
# Cerrar instancias previas de Waybar y Swaync
# -----------------------------------------------------
pkill waybar
pkill swaync
sleep 1

# -----------------------------------------------------
# Leer el tema actual desde .cache/.themestyle.sh
# -----------------------------------------------------
if [ -f ~/.cache/.themestyle.sh ]; then
    themestyle=$(cat ~/.cache/.themestyle.sh)
else
    themestyle="/classic;/classic"
    echo "$themestyle" > ~/.cache/.themestyle.sh
fi

IFS=';' read -ra arrThemes <<< "$themestyle"

# -----------------------------------------------------
# Iniciar Waybar con la configuración y estilo correctos
# -----------------------------------------------------
waybar -c ~/.config/waybar/themes${arrThemes[0]}/config -s ~/.config/waybar/themes${arrThemes[1]}/style.css &

# -----------------------------------------------------
# Configurar y ejecutar Swaync según el estilo actual
# -----------------------------------------------------
sleep 1
case "$themestyle" in
    *arriba*)       swaync -c ~/.config/sncarriba/config.json -s ~/.config/sncarriba/style.css & ;;
    *abajo*)        swaync -c ~/.config/sncabajo/config.json -s ~/.config/sncabajo/style.css & ;;
    *izquierda*)    swaync -c ~/.config/sncizq/config.json -s ~/.config/sncizq/style.css & ;;
    *abajobisel*)   swaync -c ~/.config/sncabajocentro/config.json -s ~/.config/sncabajocentro/style.css & ;;
    *arribabisel*)  swaync -c ~/.config/sncarribacentro/config.json -s ~/.config/sncarribacentro/style.css & ;;
    *revealerarriba*) swaync -c ~/.config/sncarribacentro/config.json -s ~/.config/sncarribacentro/style.css & ;;
    *revealerabajo*)  swaync -c ~/.config/sncabajocentro/config.json -s ~/.config/sncabajocentro/style.css & ;;
esac

#!/bin/bash
# Mata y recarga Waybar cuando cambia la configuración

killall waybar &
   
if [ -f ~/.cache/.themestyle.sh ]; then
    themestyle=$(cat ~/.cache/.themestyle.sh)
else
    touch ~/.cache/.themestyle.sh
    echo "$themestyle" > ~/.cache/.themestyle.sh
fi

IFS=';' read -ra arrThemes <<< "$themestyle"
echo ${arrThemes[0]}

# ----------------------------------------------------- 
# Cargando la configuración
# ----------------------------------------------------- 
config_file="config"
style_file="style.css"

if [ -f ~/dotfiles/waybar/themes${arrThemes[0]}/config-custom ] ;then
    config_file="config-custom"
fi
if [ -f ~/dotfiles/waybar/themes${arrThemes[1]}/style-custom.css ] ;then
    style_file="style-custom.css"
fi

# Revisa archivos usados por la nueva barra y carga configuraciones personalizadas de Hyprland
echo "Config: $config_file"
echo "Style: $style_file"

waybar -c ~/.config/waybar/themes${arrThemes[0]}/$config_file -s ~/.config/waybar/themes${arrThemes[1]}/$style_file &
sleep 1
~/.config/hypr/hyprctl.sh

# Funciones para determinar cuál configuración de Swaync se va a cargar

themestyle=$(cat ~/.cache/.themestyle.sh)

if [[ $themestyle == *arriba* ]]; then
    killall swaync 
    swaync -c ~/.config/sncarriba/config.json -s ~/.config/sncarriba/style.css &
fi
if [[ $themestyle == *abajo* ]]; then
    killall swaync
    swaync -c ~/.config/sncabajo/config.json -s ~/.config/sncabajo/style.css &
fi
if [[ $themestyle == *izquierda* ]]; then
    killall swaync
    swaync -c ~/.config/sncizq/config.json -s ~/.config/sncizq/style.css &
fi
if [[ $themestyle == *abajobisel* ]]; then
    killall swaync
    swaync -c ~/.config/sncabajocentro/config.json -s ~/.config/sncabajocentro/style.css &
fi
if [[ $themestyle == *arribabisel* ]]; then
    killall swaync
    swaync -c ~/.config/sncarribacentro/config.json -s ~/.config/sncarribacentro/style.css &
fi
if [[ $themestyle == *revealerarriba* ]]; then
    killall swaync
    swaync -c ~/.config/sncarribacentro/config.json -s ~/.config/sncarribacentro/style.css &
fi
if [[ $themestyle == *revealerabajo* ]]; then
    killall swaync
    swaync -c ~/.config/sncabajocentro/config.json -s ~/.config/sncabajocentro/style.css &
fi
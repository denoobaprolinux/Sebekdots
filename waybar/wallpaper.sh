#!/bin/bash

# Obtener el wallpaper seleccionado como argumento de Waypaper
wallpaper="$1"

# -----------------------------------------------------
# Aplicar esquema de colores con Pywal
# -----------------------------------------------------
wal -q -i "$wallpaper"
source "$HOME/.cache/wal/colors.sh"
echo "Wallpaper: $wallpaper"

# -----------------------------------------------------
# Notificación de cambio de fondo
# -----------------------------------------------------

# notify-send --transient "Fondo de Pantalla" "$(basename "$wallpaper")"

# -----------------------------------------------------
# Configurar imagen para Hyprlock si es GIF
# -----------------------------------------------------
if [[ $wallpaper == *.gif ]]; then
    magick "$wallpaper[0]" ~/.cache/current_wallpaper.png
    echo ~/.cache/current_wallpaper.png > "$HOME/.cache/current_wallpaper"
else
    cp "$wallpaper" ~/.cache/current_wallpaper.jpg
    magick ~/.cache/current_wallpaper.jpg ~/.cache/current_wallpaper.png
    echo "$wallpaper" > "$HOME/.cache/current_wallpaper"
fi


# -----------------------------------------------------
# Reiniciar Waybar, Cava, y actualizar Pywalfox y Walogram
# -----------------------------------------------------
~/.config/waybar/launch.sh
sleep 1
~/.config/hypr/hyprctl.sh
cp ~/.cache/wal/config ~/.config/cava/config
pywalfox update
walogram


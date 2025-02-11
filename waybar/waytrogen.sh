#!/bin/bash

# -----------------------------------------------------
# Limpiar archivos JSON de ~/.cache/wallust
# -----------------------------------------------------
# rm -f ~/.cache/wallust/*.json

# -----------------------------------------------------
# Obtener información del wallpaper seleccionado de Waytrogen
# -----------------------------------------------------
wallpaper_info=$(waytrogen --list-current-wallpapers 2>/dev/null)

# Verificar si el comando se ejecutó correctamente
if [ $? -ne 0 ]; then
  echo "Error: No se pudo ejecutar 'waytrogen -l'."
  exit 1
fi

# Extraer la ruta del wallpaper usando jq
wallpaper=$(echo "$wallpaper_info" | jq -r '.[0].path')

# Verificar si se obtuvo la ruta
if [ -z "$wallpaper" ] || [ "$wallpaper" == "null" ]; then
  echo "Error: No se pudo extraer la ruta del wallpaper."
  exit 1
fi

# -----------------------------------------------------
# Aplicar esquema de colores con Wallust
# -----------------------------------------------------
wallust run "$wallpaper"
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

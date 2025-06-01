#!/bin/bash

# -----------------------------------------------------
# Obtener información del wallpaper seleccionado de Waytrogen
# -----------------------------------------------------
wallpaper_info=$(waytrogen --list-current-wallpapers 2>/dev/null)
if [ $? -ne 0 ] || [ -z "$wallpaper_info" ]; then
  echo "Error: No se pudo ejecutar 'waytrogen --list-current-wallpapers' o no devolvió datos."
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
# Aplicar esquema de colores con Matugen
# -----------------------------------------------------
matugen image "$wallpaper"
echo "Wallpaper aplicado: $wallpaper"

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
# Actualizar hyprpaper.conf con la nueva ruta del wallpaper
# -----------------------------------------------------
hyprpaper_conf="$HOME/.config/hypr/hyprpaper.conf"
if [ -f "$hyprpaper_conf" ]; then
    sed -i "s|^preload = .*|preload = $wallpaper|" "$hyprpaper_conf"
    sed -i "s|^wallpaper = .*|wallpaper = ,$wallpaper|" "$hyprpaper_conf"
    echo "hyprpaper.conf actualizado."
else
    echo "Error: No se encontró el archivo hyprpaper.conf."
    exit 1
fi

# -----------------------------------------------------
# Reiniciar Waybar y Swaync con carga correcta del esquema de colores
# -----------------------------------------------------
sleep 2
~/.config/waybar/launch.sh
pywalfox update
walogram
~/.config/hypr/hyprctl.sh

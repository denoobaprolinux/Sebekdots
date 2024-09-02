#!/bin/bash

# Dependencias: imagemagick

# Crear las carpetas si no existen
thumbs_dir="$HOME/.cache/wallpapers"
mkdir -p "$thumbs_dir"


# Función para generar miniaturas
generate_thumbnail() {
    local wallpaper="$1"
    local extension="${wallpaper##*.}"
    local thumbnail="$thumbs_dir/$(basename "$wallpaper").png"

    if [ ! -f "$thumbnail" ]; then
        if [ "$extension" = "gif" ]; then
            magick "$wallpaper[0]" -thumbnail 200x200 "$thumbnail"  # Crear miniatura desde el primer frame del GIF
        else
            magick "$wallpaper" -thumbnail 200x200 "$thumbnail"
        fi
    fi
}

## Crear archivos caché con la información del wallpaper
cache_file="$HOME/.cache/current_wallpaper"
rasi_file="$HOME/.cache/current_wallpaper.rasi"

# Crear el archivo caché si no existe
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$HOME/wallpaper/default.jpg" > "$cache_file"
fi

# Crear el archivo rasi si no existe
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/wallpaper/default.jpg\", height); }" > "$rasi_file"
fi

current_wallpaper=$(cat "$cache_file")

case $1 in

    # Cargar el wallpaper de .cache de la última sesión
    "init")
        if [ -f $cache_file ]; then
            wal -q -i $current_wallpaper
        else
            wal -q -i ~/Imágenes/Wallpapers/Set/
        fi
    ;;

    # Seleccionar wallpaper con rofi
    "select")

        selected=$( find "$HOME/Imágenes/Wallpapers/Set/" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -exec basename {} \; | sort -R | while read rfile
        do
            generate_thumbnail "$HOME/Imágenes/Wallpapers/Set/$rfile"  # Generar miniatura
            echo -en "$rfile\x00icon\x1f$thumbs_dir/${rfile}.png\n"
        done | rofi -dmenu -replace -disable-history -sort -config ~/.config/rofi/config-wallpaper.rasi)
        if [ ! "$selected" ]; then
            echo "No se ha seleccionado ningún wallpaper"
            exit
        fi
        wallpaper="$HOME/Imágenes/Wallpapers/Set/$selected"
    ;;

    # Selección aleatoria de wallpaper
    *)
        wallpaper=$(find "$HOME/Imágenes/Wallpapers/Set/" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | sort -R | head -n 1)
    ;;

esac

# -----------------------------------------------------
# Cargar esquema de colores con Pywal
# -----------------------------------------------------
wal -q -i "$wallpaper"
source "$HOME/.cache/wal/colors.sh"
echo "Wallpaper: $wallpaper"

# -----------------------------------------------------
# Escribir el wallpaper seleccionado al archivo .cache y generar current_wallpaper
# -----------------------------------------------------

# Caso 1: GIF
if [[ $wallpaper == *.gif ]]; then
    magick "$wallpaper[0]" ~/.cache/current_wallpaper.png
    echo ~/.cache/current_wallpaper.png > "$cache_file"
    echo "* { current-image: url(\"$wallpaper\", height); }" > "$rasi_file"
else
# Caso 2: Imagen
    echo "$wallpaper" > "$cache_file"
    echo "* { current-image: url(\"$wallpaper\", height); }" > "$rasi_file"
    cp $wallpaper ~/.cache/current_wallpaper.jpg
    magick ~/.cache/current_wallpaper.jpg ~/.cache/current_wallpaper.png
fi

# -----------------------------------------------------
# Obtener nombre del wallpaper y mostrarlo con swww
# -----------------------------------------------------
newwall=$(echo $wallpaper | sed "s|~/Imágenes/Wallpapers/||g")

# Verificar si el wallpaper es un GIF y usar swww correctamente
if [[ $wallpaper == *.gif ]]; then
    swww img "$wallpaper"\
        --transition-bezier .43,1.19,1,.4\
        --transition-fps=30\
        --transition-step=20\
        --transition-angle=0\
        --transition-type=any\
        --transition-duration=0.5\
        --transition-pos "$(hyprctl cursorpos)"
else
    swww img ~/.cache/current_wallpaper.jpg\
        --transition-bezier .43,1.19,1,.4\
        --transition-fps=30\
        --transition-step=20\
        --transition-angle=0\
        --transition-type=any\
        --transition-duration=0.5\
        --transition-pos "$(hyprctl cursorpos)"
fi

# -----------------------------------------------------
# Matar Swaync y Waybar, y volver a cargar todo
# -----------------------------------------------------

~/.config/waybar/launch.sh
sleep 1
~/.config/hypr/hyprctl.sh

# -----------------------------------------------------
# Envía la notificación
# -----------------------------------------------------

# notify-send "Colores y Fondo de Pantalla" "con imagen $newwall"

#!/bin/bash


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

        selected=$( find "$HOME/Imágenes/Wallpapers/Set/" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
        do
            echo -en "$rfile\x00icon\x1f$HOME/Imágenes/Wallpapers/Set/${rfile}\n"
        done | rofi -dmenu -replace -disable-history -sort -config ~/.config/rofi/config-wallpaper.rasi)
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
        wal -q -i ~/Imágenes/Wallpapers/Set/$selected
    ;;

    # Randomly select wallpaper 
    *)
        wal -q -i ~/Imágenes/Wallpapers/Set/
    ;;

esac

# ----------------------------------------------------- 
# Cargar esquema de colores con Pywal
# ----------------------------------------------------- 
source "$HOME/.cache/wal/colors.sh"
echo "Wallpaper: $wallpaper"

# ----------------------------------------------------- 
# Escribir el wallpaper seleccionado al archivo .cache y generar current_wallpaper
# ----------------------------------------------------- 

echo "$wallpaper" > "$cache_file"
echo "* { current-image: url(\"$wallpaper\", height); }" > "$rasi_file"
cp $wallpaper ~/.cache/current_wallpaper.jpg

# ----------------------------------------------------- 
# Matar Swaync y Waybar, y volver a cargar todo
# ----------------------------------------------------- 

~/.config/waybar/launch.sh
sleep 1

# ----------------------------------------------------- 
# Obtener nombre del wallpaper y mostrarlo con swww
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|~/Imágenes/Wallpapers/||g")

swww img ~/.cache/current_wallpaper.jpg \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type="simple" \
    --transition-duration=0.5 \
    --transition-pos "$( hyprctl cursorpos )"

# ----------------------------------------------------- 
# Envía la notificación
# ----------------------------------------------------- 
notify-send "Colores y Fondo de Pantalla" "con imagen $newwall"

echo "Listo!"

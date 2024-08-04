#!/bin/bash

# Crear la carpeta ./cache/wallpapers si no existe
thumbs_dir="$HOME/.cache/wallpapers"
mkdir -p "$thumbs_dir"

# Función para generar miniaturas
generate_thumbnail() {
    local wallpaper="$1"
    local thumbnail="$thumbs_dir/$(basename "$wallpaper").png"
    if [ ! -f "$thumbnail" ]; then
        magick convert "$wallpaper" -thumbnail 200x200 "$thumbnail"
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

        selected=$( find "$HOME/Imágenes/Wallpapers/Set/" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
        do
            generate_thumbnail "$HOME/Imágenes/Wallpapers/Set/$rfile"  # Generar miniatura
            echo -en "$rfile\x00icon\x1f$thumbs_dir/${rfile}.png\n"
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
# Ejecutar el generador de colores en Starship
# ----------------------------------------------------- 

cp ~/.config/starship/starship.toml.bak ~/.config/starship.toml 

# Ruta del archivo starship.toml
starship_toml="$HOME/.config/starship.toml"

# Reemplazar los colores en starship.toml
sed -i -e "s/bg:color_orange/bg:$color1/g" \
       -e "s/fg:color_orange/fg:$color1/g" \
       -e "s/bg:color_yellow/bg:$color2/g" \
       -e "s/fg:color_yellow/fg:$color2/g" \
       -e "s/bg:color_aqua/bg:$color3/g" \
       -e "s/fg:color_aqua/fg:$color3/g" \
       -e "s/bg:color_blue/bg:$color4/g" \
       -e "s/fg:color_blue/fg:$color4/g" \
       -e "s/bg:color_bg3/bg:$color5/g" \
       -e "s/fg:color_bg3/fg:$color5/g" \
       -e "s/bg:color_bg1/bg:$color6/g" \
       -e "s/fg:color_bg1/fg:$color6/g" \
       -e "s/fg:color_fg0/fg:#FFFFFF/g" \
       -e "s/\[\](color_orange)/\[\]($color1)/g" "$starship_toml"

# ----------------------------------------------------- 
# Escribir el wallpaper seleccionado al archivo .cache y generar current_wallpaper
# ----------------------------------------------------- 

echo "$wallpaper" > "$cache_file"
echo "* { current-image: url(\"$wallpaper\", height); }" > "$rasi_file"
cp $wallpaper ~/.cache/current_wallpaper.jpg
magick ~/.cache/current_wallpaper.jpg ~/.cache/current_wallpaper.png # instalar imagemagick para que esto funcione
cp ~/.cache/current_wallpaper.png ~/.mozilla/firefox/7p9u4mig.default-release/chrome/newtab/wallpaper-dark1.png

# ----------------------------------------------------- 
# Matar Swaync y Waybar, y volver a cargar todo
# ----------------------------------------------------- 

~/.config/waybar/launch.sh
sleep 1
~/.config/hypr/hyprctl.sh

# ----------------------------------------------------- 
# Obtener nombre del wallpaper y mostrarlo con swww
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|~/Imágenes/Wallpapers/||g")

swww img ~/.cache/current_wallpaper.jpg\
    --transition-bezier .43,1.19,1,.4\
    --transition-fps=30\
    --transition-step=20\
    --transition-angle=0\
    --transition-type=any\
    --transition-duration=0.5\
    --transition-pos "$( hyprctl cursorpos )"

# ----------------------------------------------------- 
# Envía la notificación
# ----------------------------------------------------- 

# notify-send "Colores y Fondo de Pantalla" "con imagen $newwall"

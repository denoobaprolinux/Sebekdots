#!/bin/bash

# ----------------------------------------------------- 
# Carpeta de Temas
# ----------------------------------------------------- 
themes_path="$HOME/.config/waybar/themes"

# ----------------------------------------------------- 
# Inicializar Arreglos
# ----------------------------------------------------- 
listThemes=""
listNames=""

# ----------------------------------------------------- 
# Leer carpeta de temas
# ----------------------------------------------------- 
options=$(find $themes_path -maxdepth 2 -type d)
for value in $options
do
    if [ ! $value == "$themes_path" ]; then
        if [ $(find $value -maxdepth 1 -type d | wc -l) = 1 ]; then
            result=$(echo $value | sed "s#$HOME/.config/waybar/themes/#/#g")
            IFS='/' read -ra arrThemes <<< "$result"
            listThemes[${#listThemes[@]}]="/${arrThemes[1]};$result"
            if [ -f $themes_path$result/config.sh ]; then
                source $themes_path$result/config.sh
                listNames+="$theme_name\n"
            else
                listNames+="/${arrThemes[1]};$result\n"
            fi
        fi
    fi
done

# ----------------------------------------------------- 
# Mostrar ventana de Rofi
# ----------------------------------------------------- 
listNames=${listNames::-2}
choice=$(echo -e "$listNames" | rofi -dmenu -i -replace -config $HOME/.config/rofi/config-themes.rasi -no-show-icons -width 30 -p "Themes" -format i) 

# ----------------------------------------------------- 
# Elegir nuevo tema escribiendo la selección en ~/.cache/.themestyle.sh
# ----------------------------------------------------- 
if [ "$choice" ]; then
    echo "Cargando tema de Waybar..."
    echo "${listThemes[$choice+1]}" > ~/.cache/.themestyle.sh
    ~/.config/waybar/reload.sh
fi




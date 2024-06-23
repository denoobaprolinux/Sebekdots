#!/bin/bash

# Definir opciones de configuración y sus tipos de valores posibles
declare -A options=(
    ["Configuración por defecto"]="reload"
    ["Animaciones"]="true false"
    ["Anchura de bordes de ventanas"]="numeric"
    ["Gaps Internos"]="numeric"
    ["Gaps Externos"]="numeric"
    ["Efecto Blur"]="true false"
    ["Smart Gaps (0/1/2)"]="numeric"
    ["Efecto Neón"]="yes no"
    ["Intensidad de Efecto Neón"]="numeric"
    ["Esquinas"]="numeric"
)

# Ruta al script hyprctl.sh que se ejecutará al inicio
hyprctl_script=~/.config/hypr/hyprctl.sh

# Crear hyprctl.sh si no existe y asegurarse de que es ejecutable
if [ ! -f $hyprctl_script ]; then
    echo "#!/bin/bash" > $hyprctl_script
    chmod +x $hyprctl_script
fi

# Función para agregar o reemplazar una línea en hyprctl.sh
update_hyprctl_script() {
    local key=$1
    local value=$2
    local file=$3
    local pattern="^hyprctl keyword $key"

    if grep -q "$pattern" "$file"; then
        # Reemplazar la línea existente
        sed -i "s|$pattern.*|hyprctl keyword $key $value|" "$file"
    else
        # Añadir una nueva línea
        echo "hyprctl keyword $key $value" >> "$file"
    fi
}

# Mostrar el menú para seleccionar la opción
selected_option=$(printf "%s\n" "${!options[@]}" | rofi -dmenu -i -replace -config $HOME/.config/rofi/config-themes.rasi -no-show-icons -width 30 "Seleccione opción de Hyprland:")

# Si se selecciona una opción, proceder
if [ -n "$selected_option" ]; then
    option_type=${options[$selected_option]}
    if [ "$option_type" == "numeric" ]; then
        # Permitir la entrada de un valor numérico
        selected_value=$(rofi -dmenu -i -replace -config $HOME/.config/rofi/config-themes.rasi -no-show-icons -width 30 "Introduzca valor para $selected_option:")
    else
        # Mostrar el menú para seleccionar el valor predefinido
        selected_value=$(printf "%s\n" $option_type | rofi -dmenu -i -replace -config $HOME/.config/rofi/config-themes.rasi -no-show-icons -width 30 "Seleccione valor para $selected_option:")
    fi

    if [ -n "$selected_value" ]; then
        # Ejecutar hyprctl con el comando adecuado basado en la opción seleccionada
        case $selected_option in
            "Animaciones")
                hyprctl keyword animations:enabled $selected_value
                update_hyprctl_script "animations:enabled" $selected_value $hyprctl_script
                ;;
            "Anchura de bordes de ventanas")
                hyprctl keyword general:border_size $selected_value
                update_hyprctl_script "general:border_size" $selected_value $hyprctl_script
                ;;
            "Gaps Internos")
                hyprctl keyword general:gaps_in $selected_value
                update_hyprctl_script "general:gaps_in" $selected_value $hyprctl_script
                ;;
            "Gaps Externos")
                hyprctl keyword general:gaps_out $selected_value
                update_hyprctl_script "general:gaps_out" $selected_value $hyprctl_script
                ;;
            "Efecto Blur")
                hyprctl keyword decoration:blur:enabled $selected_value
                update_hyprctl_script "decoration:blur:enabled" $selected_value $hyprctl_script
                ;;
            "Smart Gaps (0/1/2)")
                hyprctl keyword dwindle:no_gaps_when_only $selected_value
                update_hyprctl_script "dwindle:no_gaps_when_only" $selected_value $hyprctl_script
                ;;
            "Configuración por defecto")
                hyprctl $selected_value
                echo "#!/bin/bash" > $hyprctl_script
                chmod +x $hyprctl_script
                ;;
            "Efecto Neón")
                hyprctl keyword decoration:drop_shadow $selected_value
                update_hyprctl_script "decoration:drop_shadow" $selected_value $hyprctl_script
                ;;
            "Esquinas")
                hyprctl keyword decoration:rounding $selected_value
                update_hyprctl_script "decoration:rounding" $selected_value $hyprctl_script
                ;;
            "Intensidad de Efecto Neón")
                hyprctl keyword decoration:shadow_range $selected_value
                update_hyprctl_script "decoration:shadow_range" $selected_value $hyprctl_script
        esac
        notify-send "Configuración de Hyprland" "Actualizado: $selected_option = $selected_value"
    fi
fi

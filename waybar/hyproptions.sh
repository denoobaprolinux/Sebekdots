#!/bin/bash

#   ____             __ _                            _                       
#  / ___|___  _ __  / _(_) __ _ _   _ _ __ __ _  ___(_) ___  _ __   ___  ___ 
# | |   / _ \| '_ \| |_| |/ _` | | | | '__/ _` |/ __| |/ _ \| '_ \ / _ \/ __|
# | |__| (_) | | | |  _| | (_| | |_| | | | (_| | (__| | (_) | | | |  __/\__ \
#  \____\___/|_| |_|_| |_|\__, |\__,_|_|  \__,_|\___|_|\___/|_| |_|\___||___/
#                         |___/                                              
#      _        _   _                  _                 _ 
#   __| | ___  | | | |_   _ _ __  _ __| | __ _ _ __   __| |
#  / _` |/ _ \ | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
# | (_| |  __/ |  _  | |_| | |_) | |  | | (_| | | | | (_| |
#  \__,_|\___| |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
#                     |___/|_|                             

# Opciones desplegadas en Rofi

declare -A options=(
    ["1. Configuración por defecto"]="Aceptar Atrás"
    ["2. Anchura de Bordes de Ventanas"]="numeric"
    ["3. Gaps Internos"]="numeric"
    ["4. Gaps Externos"]="numeric"
    ["5. Smart Gaps (0/1/2)"]="numeric"
    ["6. Efecto Blur"]="1.Encendido 2.Apagado 3.Atrás"
    ["7. Efecto Neón"]="1.Encendido 2.Apagado 3.Atrás"
    ["8. Efecto Neón - Intensidad"]="numeric"
    ["9. Redimensionar Ventanas"]="1.Encendido 2.Apagado 3.Atrás"
    ["10. Redimensionar Ventanas - Área"]="numeric"
    ["11. Esquinas"]="numeric"
    ["12. Animaciones"]="Estándar Rápidas Fluidas Máximas Apagadas"
)

# Creación/Actualización del script hyprctl.sh

hyprctl_script=~/.config/hypr/hyprctl.sh

if [ ! -f "$hyprctl_script" ]; then
    echo "#!/bin/bash" > "$hyprctl_script"
    chmod +x "$hyprctl_script"
fi

# Actualizar hyprctl.sh cada vez que haya un cambio

update_hyprctl_script() {
    local key=$1
    local value=$2
    local file=$3
    local pattern="^hyprctl keyword $key"

    if grep -q "$pattern" "$file"; then
        sed -i "s|$pattern.*|hyprctl keyword $key $value|" "$file"
    else
        echo "hyprctl keyword $key $value" >> "$file"
    fi
}

# Seleccionar opciones en Rofi

selected_option=$(printf "%s\n" "${!options[@]}" | sort -n | rofi -dmenu -i -replace -config "$HOME/.config/rofi/config-hypr.rasi" -no-show-icons -width 30 "Seleccione opción de Hyprland:")

if [ -n "$selected_option" ]; then
    option_type=${options[$selected_option]}
    if [ "$option_type" == "numeric" ]; then
        selected_value=$(rofi -dmenu -i -replace -config "$HOME/.config/rofi/config-hypr.rasi" -no-show-icons -width 30 "Introduzca valor para $selected_option:")
    else
        selected_value=$(printf "%s\n" $option_type | sort | rofi -dmenu -i -replace -config "$HOME/.config/rofi/config-hypr.rasi" -no-show-icons -width 30 "Seleccione valor para $selected_option:")
    fi

    if [ -n "$selected_value" ]; then
        case $selected_option in
             "1. Configuración por defecto")
                case $selected_value in 
                    "Aceptar")
                        hyprctl reload
                        echo "#!/bin/bash" > "$hyprctl_script"
                        chmod +x "$hyprctl_script"
                        cp ~/.config/hypr/config/animations/animations-default.conf ~/.config/hypr/config/animations.conf
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "Atrás")
                        ~/.config/waybar/hyproptions.sh
                esac
                ;;
            "2. Anchura de Bordes de Ventanas")
                hyprctl keyword general:border_size "$selected_value"
                update_hyprctl_script "general:border_size" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "3. Gaps Internos")
                hyprctl keyword general:gaps_in "$selected_value"
                update_hyprctl_script "general:gaps_in" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "4. Gaps Externos")
                hyprctl keyword general:gaps_out "$selected_value"
                update_hyprctl_script "general:gaps_out" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "5. Smart Gaps (0/1/2)")
                hyprctl keyword dwindle:no_gaps_when_only "$selected_value"
                update_hyprctl_script "dwindle:no_gaps_when_only" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "6. Efecto Blur")
                case $selected_value in
                    "1.Encendido")
                        hyprctl keyword decoration:blur:enabled true
                        update_hyprctl_script "decoration:blur:enabled" "true" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "2.Apagado")
                        hyprctl keyword decoration:blur:enabled false
                        update_hyprctl_script "decoration:blur:enabled" "false" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "3.Atrás")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac
                ;;
            "7. Efecto Neón")
                case $selected_value in
                    "1.Encendido")
                        hyprctl keyword decoration:drop_shadow true
                        update_hyprctl_script "decoration:drop_shadow" "true" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "2.Apagado")
                        hyprctl keyword decoration:drop_shadow false
                        update_hyprctl_script "decoration:drop_shadow" "false" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "3.Atrás")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac
                ;;
            "8. Efecto Neón - Intensidad")
                hyprctl keyword decoration:shadow_range "$selected_value"
                update_hyprctl_script "decoration:shadow_range" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "9. Redimensionar Ventanas")
                case $selected_value in
                    "1.Encendido")
                        hyprctl keyword general:resize_on_border true
                        update_hyprctl_script "general:resize_on_border" "true" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "2.Apagado")
                        hyprctl keyword general:resize_on_border false
                        update_hyprctl_script "general:resize_on_border" "false" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "3.Atrás")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac
                ;;
            "10. Redimensionar Ventanas - Área")
                hyprctl keyword general:extend_border_grab_area "$selected_value"
                update_hyprctl_script "general:extend_border_grab_area" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "11. Esquinas")
                hyprctl keyword decoration:rounding "$selected_value"
                update_hyprctl_script "decoration:rounding" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "12. Animaciones")
                case $selected_value in
                    "Máximas")
                        cp ~/.config/hypr/config/animations/animations-maximum.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                    "Rápidas")
                        cp ~/.config/hypr/config/animations/animations-fast.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                    "Fluidas")
                        cp ~/.config/hypr/config/animations/animations-fluid.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                    "Estándar")
                        cp ~/.config/hypr/config/animations/animations-default.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                    "Apagadas")
                        update_hyprctl_script "animations:enabled" "false" "$hyprctl_script"
                        ;;
                esac
                ~/.config/waybar/hyproptions.sh
                ;;        
        esac
        
        #notify-send "Configuración de Hyprland" "Actualizado: $selected_option = $selected_value"

    fi
    ~/.config/hypr/hyprctl.sh
fi
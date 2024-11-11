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
    ["5. Smart Gaps"]="1.Encendido 2.Apagado 3.Atrás"
    ["6. Efecto Blur"]="1.Encendido 2.Apagado 3.Atrás"
    ["7. Efecto Neón"]="1.Encendido 2.Apagado 3.Atrás"
    ["8. Efecto Neón - Rango"]="numeric"
    ["9. Efecto Neón - Intensidad"]="numeric"
    ["10. Redimensionar Ventanas"]="1.Encendido 2.Apagado 3.Atrás"
    ["11. Redimensionar Ventanas - Área"]="numeric"
    ["12. Esquinas"]="numeric"
    ["13. Animaciones"]="1.Apagadas 2.Estándar 3.Desvanecer 4.Rápidas 5.Fluidas 6.Máximas"
    ["14. Oscurecimiento"]="1.Encendido 2.Apagado 3.Atrás"
    ["15. Oscurecimiento - Intensidad"]="numeric"
    ["16. Opacidad (Ventana Activa)"]="numeric"
    ["17. Opacidad (Ventana Inactiva)"]="numeric"
    ["18. Efecto Rayos X"]="1.Encendido 2.Apagado 3.Atrás"
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
        selected_value=$(rofi -dmenu -i -replace -config "$HOME/.config/rofi/config-submenu.rasi" -no-show-icons -width 30 "Introduzca valor para $selected_option:")
    else
        selected_value=$(printf "%s\n" $option_type | sort | rofi -dmenu -i -replace -config "$HOME/.config/rofi/config-submenu.rasi" -no-show-icons -width 30 "Seleccione valor para $selected_option:")
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
            "5. Smart Gaps")
                case $selected_value in
                    "1.Encendido")
                        cp ~/.config/hypr/config/gaps/gaps_on.conf ~/.config/hypr/config/gaps.conf
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "2.Apagado")
                        cp ~/.config/hypr/config/gaps/gaps_off.conf ~/.config/hypr/config/gaps.conf
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "3.Atrás")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac
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
                        update_hyprctl_script "decoration:shadow:enabled" "true" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "2.Apagado")
                        hyprctl keyword decoration:drop_shadow false
                        update_hyprctl_script "decoration:shadow:enabled" "false" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "3.Atrás")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac
                ;;
            "8. Efecto Neón - Rango")
                hyprctl keyword decoration:shadow_range "$selected_value"
                update_hyprctl_script "decoration:shadow:range" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "9. Efecto Neón - Intensidad")
                hyprctl keyword decoration:shadow_range "$selected_value"
                update_hyprctl_script "decoration:shadow:render_power" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "10. Redimensionar Ventanas")
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
            "11. Redimensionar Ventanas - Área")
                hyprctl keyword general:extend_border_grab_area "$selected_value"
                update_hyprctl_script "general:extend_border_grab_area" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "12. Esquinas")
                hyprctl keyword decoration:rounding "$selected_value"
                update_hyprctl_script "decoration:rounding" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "13. Animaciones")
                case $selected_value in
                    "1.Apagadas")
                        update_hyprctl_script "animations:enabled" "false" "$hyprctl_script"
                        ;;
                    "2.Estándar")
                        cp ~/.config/hypr/config/animations/animations-default.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                    "3.Desvanecer")
                        cp ~/.config/hypr/config/animations/animations-fade.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                    "4.Rápidas")
                        cp ~/.config/hypr/config/animations/animations-fast.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                    "5.Fluidas")
                        cp ~/.config/hypr/config/animations/animations-fluid.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                    "6.Máximas")
                        cp ~/.config/hypr/config/animations/animations-maximum.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                esac
                ~/.config/waybar/hyproptions.sh
                ;;
            "14. Oscurecimiento")
                case $selected_value in
                    "1.Encendido")
                        hyprctl keyword decoration:dim_inactive true
                        update_hyprctl_script "decoration:dim_inactive" "true" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "2.Apagado")
                        hyprctl keyword decoration:dim_inactive false
                        update_hyprctl_script "decoration:dim_inactive" "false" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "3.Atrás")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac
                ;;
            "15. Oscurecimiento - Intensidad")
                hyprctl keyword decoration:dim_strength "$selected_value"
                update_hyprctl_script decoration:dim_strength "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "16. Opacidad (Ventana Activa)")
                hyprctl keyword decoration:active_opacity "$selected_value"
                update_hyprctl_script decoration:active_opacity "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "17. Opacidad (Ventana Inactiva)")
                hyprctl keyword decoration:inactive_opacity "$selected_value"
                update_hyprctl_script decoration:inactive_opacity "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;  
            "18. Efecto Rayos X")
                case $selected_value in
                    "1.Encendido")
                        hyprctl keyword decoration:blur:xray true
                        update_hyprctl_script "decoration:blur:xray" "true" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "2.Apagado")
                        hyprctl keyword decoration:blur:xray false
                        update_hyprctl_script "decoration:blur:xray" "false" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "3.Atrás")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac            
        esac
        
        #notify-send "Configuración de Hyprland" "Actualizado: $selected_option = $selected_value"

    fi
    ~/.config/hypr/hyprctl.sh
fi
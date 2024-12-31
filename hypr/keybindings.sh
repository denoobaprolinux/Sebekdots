#!/bin/bash

# GDK BACKEND. 
BACKEND=wayland

# Revisa si Rofi está en ejecución y lo mata de ser el caso
if pgrep -x "rofi" > /dev/null; then
    pkill rofi
fi

# Detecta resolución del monitor y escalado
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

# Calcula tamaño de la ventana en función de la resolución de la pantalla
width=$((x_mon * hypr_scale / 100))
height=$((y_mon * hypr_scale / 100))

# Fija altura y anchura máximos
max_width=1200
max_height=1000

# Elige porcentaje de tamaño de la pantalla para ajuste dinámico
percentage_width=70
percentage_height=70

# Calcula altura y anchura dinámicos
dynamic_width=$((width * percentage_width / 100))
dynamic_height=$((height * percentage_height / 100))

# Limita altura y anchura de la ventana
dynamic_width=$(($dynamic_width > $max_width ? $max_width : $dynamic_width))
dynamic_height=$(($dynamic_height > $max_height ? $max_height : $dynamic_height))

# Ejecuta Yad con los valores elegidos en las funciones anteriores
GDK_BACKEND=$BACKEND yad --width=$dynamic_width --height=$dynamic_height \
    --center \
    --title="Atajos de Teclas de Sebekdots" \
    --no-buttons \
    --list \
    --column=Teclas: \
    --column=Descripción: \
    --column=Comando/Función/Programa: \
    --timeout-indicator=top \
"  + A" "Abre esta Ventana" "" \
"ESC" "Cierra esta Ventana" "También con   + Q" \
"  + Enter" "Terminal" "kitty" \
"  + Q" "Cerrar Ventana Activa" "Opciones de Hyprland" \
"  + M" "Cerrar Hyprland" "Opciones de Hyprland" \
"  + H" "Recargar Personalizaciones de Hyprland" "Script hyprctl.sh" \
"  + Shift + H" "Configuraciones de Hyprland" "Script hyprctl.sh" \
"  + Shift + R" "Recargar Waybar" "Script reload.sh" \
"  + Shift + Q" "Cargar Barra Waybar por Defecto" "Barra Clásica/Abajo" \
"  + E" "Abre Explorador de Archivos" "Nautilus" \
"  + F" "Ejecutar Navegador Web" "Firefox" \
"  + N" "Abre el Centro de Notificaciones" "Sway Notification Center" \
"  + Shift + W" "Abrir Waypaper" "Waypaper" \
"  + W" "Elegir Wallpaper Aleatorio" "Waypaper --random" \
"  + Shift + B" "Seleccionar Tema de Waybar" "Script themeswitcher.sh" \
"  + B" "Esconder/Mostrar Waybar" "Waybar" \
"  + L" "Bloquear Pantalla" "Hyprlock" \
"  + V" "Ventana Flotante" "Ventana Seleccionada" \
"  + T" "Una Ventana Ocupa Pantalla Completa" "Activar/Desactivar" \
"  + P" "Pseudo Dwindle" "Opciones de Hyprland" \
"  + J" "Alternar Ventanas Horizontal/Vertical" "Dos Ventanas" \
"  + Shift + T" "Activar/Desactivar Modo Pestañas" "Opciones de Hyprland" \
"  + TAB" "Abrir Vista General de Espacios de Trabajo" "Hyprexpo" \
"  + S" "'Minimiza' y 'Maximiza' Ventana Activa" "Espacio de Trabajo Especial" \
"PrintScreen" "Captura de Pantalla" "grim + swappy" \
"  + PrintScreen" "Área de Captura de Pantalla" "grim + slurp + swappy" \
"CTRL + PrintScreen" "Captura de Pantalla (sin edición)" "Script grimblast.sh" \
"Shift Izq. + Shift Der." "Cambiar Idioma del Teclado" "Opciones de Hyprland" \
"" "" "" \

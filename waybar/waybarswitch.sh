#!/bin/bash

# Estado inicial de Waybar
WAYBAR_HIDDEN=0

# Función para ocultar Waybar
hide_waybar() {
    if [ "$WAYBAR_HIDDEN" -eq 0 ]; then
        pkill -USR2 waybar
        WAYBAR_HIDDEN=1
    fi
}

# Función para mostrar Waybar
show_waybar() {
    if [ "$WAYBAR_HIDDEN" -eq 1 ]; then
        pkill -USR2 waybar
        WAYBAR_HIDDEN=0
    fi
}

# Comprobación continua del estado de las ventanas
while true; do
    # Obtener la lista de ventanas activas
    ACTIVE_WINDOWS=$(hyprctl clients | grep "window:")

    if [ -n "$ACTIVE_WINDOWS" ]; then
        hide_waybar
    else
        show_waybar
    fi

    # Intervalo de comprobación
    sleep 0.5
done

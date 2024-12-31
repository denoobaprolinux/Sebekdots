#!/bin/bash

# Ruta completa a eww
EWW_PATH="$HOME/.local/bin/eww"

# Nombre del widget
WIDGET_NAME="audio-widget-left-up"

# Verificar si el widget está abierto
if $EWW_PATH active-windows | grep -q "$WIDGET_NAME"; then
  # Si el widget está abierto, cerrarlo
  $EWW_PATH close "$WIDGET_NAME"
else
  # Si el widget no está abierto, abrirlo
  $EWW_PATH open "$WIDGET_NAME"
fi

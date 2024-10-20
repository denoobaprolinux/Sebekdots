#!/bin/bash

# Definir los niveles de batería y el archivo temporal para guardar el estado
GOOD_LEVEL=95
WARNING_LEVEL=20
CRITICAL_LEVEL=15
STATE_FILE="/tmp/battery_notification_state"

# Obtener el porcentaje actual de la batería y el estado (si está descargándose)
BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT1/status)

# Leer el estado anterior de la batería desde el archivo, o inicializarlo si no existe
if [ -f "$STATE_FILE" ]; then
    PREVIOUS_STATE=$(cat "$STATE_FILE")
else
    PREVIOUS_STATE="normal"
fi

# Verificar si la batería está descargándose
if [[ "$BATTERY_STATUS" == "Discharging" ]]; then
    # Si la batería está por debajo del nivel crítico y el estado anterior era normal, enviar notificación
    if [[ "$BATTERY_LEVEL" -le $CRITICAL_LEVEL && "$PREVIOUS_STATE" != "critical" ]]; then
        notify-send -u critical "Batería Crítica" "Batería al $BATTERY_LEVEL%. Conecta el cargador."
        echo "critical" > "$STATE_FILE"  # Actualizar el estado a 'critical'

    # Si la batería está por debajo del nivel de advertencia pero no crítica, y el estado anterior no es warning
    elif [[ "$BATTERY_LEVEL" -le $WARNING_LEVEL && "$BATTERY_LEVEL" -gt $CRITICAL_LEVEL && "$PREVIOUS_STATE" != "warning" ]]; then
        notify-send -u normal "Batería Baja" "Batería al $BATTERY_LEVEL%. Considera conectar el cargador."
        echo "warning" > "$STATE_FILE"  # Actualizar el estado a 'warning'

    # Si la batería está por encima del nivel de advertencia, restablecer el estado a normal
    elif [[ "$BATTERY_LEVEL" -gt $WARNING_LEVEL && "$PREVIOUS_STATE" != "normal" ]]; then
        echo "normal" > "$STATE_FILE"  # Actualizar el estado a 'normal'
    fi
fi

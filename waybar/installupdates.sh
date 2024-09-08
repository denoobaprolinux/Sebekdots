#!/bin/bash

# ----------------------------------------------------- 
# Requerido: yay, trizen, flatpak, snapd
# ----------------------------------------------------- 

sleep 1
clear

cat <<"EOF"
    _        _               _ _               _                       
   / \   ___| |_ _   _  __ _| (_)______ _  ___(_) ___  _ __   ___  ___ 
  / _ \ / __| __| | | |/ _` | | |_  / _` |/ __| |/ _ \| '_ \ / _ \/ __|
 / ___ \ (__| |_| |_| | (_| | | |/ / (_| | (__| | (_) | | | |  __/\__ \
/_/   \_\___|\__|\__,_|\__,_|_|_/___\__,_|\___|_|\___/|_| |_|\___||___/                    

EOF

# ------------------------------------------------------
# Flag para verificar si hubo actualizaciones
# ------------------------------------------------------
updates_performed=false
all_updates_skipped=true # Para detectar si se rechazaron todas las actualizaciones

# ------------------------------------------------------
# Manejar interrupciones (Ctrl+C)
# ------------------------------------------------------
trap "echo 'Actualización interrumpida. Nada fue instalado.'; notify-send 'Centro de Actualizaciones:' 'Actualización cancelada'; exit 1" SIGINT

# ------------------------------------------------------
# Verifica actualizaciones para Flatpak
# ------------------------------------------------------
_updateFlatpak() {
    updates_flatpak=0
    if command -v flatpak > /dev/null 2>&1; then
        updates_flatpak=$(flatpak update --appstream 2> /dev/null | grep -c 'Update:')
        if [ "$updates_flatpak" -gt 0 ]; then
            echo "Actualizaciones de Flatpak disponibles: $updates_flatpak"
            read -p "¿Quieres actualizar Flatpak? (s/n): " flatpak_confirm
            if [[ "$flatpak_confirm" =~ [sS] ]]; then
                flatpak update
                updates_performed=true
                all_updates_skipped=false
            fi
        else
            echo "No hay actualizaciones para Flatpak."
        fi
    else
        echo "Flatpak no está instalado."
    fi
    return $updates_flatpak
}

# ------------------------------------------------------
# Verifica actualizaciones para Snap
# ------------------------------------------------------
_updateSnap() {
    updates_snap=0
    if command -v snap > /dev/null 2>&1; then
        updates_snap=$(snap refresh --list 2> /dev/null | wc -l)
        if [ "$updates_snap" -gt 0 ]; then
            echo "Actualizaciones de Snap disponibles: $updates_snap"
            read -p "¿Quieres actualizar Snap? (s/n): " snap_confirm
            if [[ "$snap_confirm" =~ [sS] ]]; then
                snap refresh
                updates_performed=true
                all_updates_skipped=false
            fi
        else
            echo "No hay actualizaciones para Snap."
        fi
    else
        echo "Snap no está instalado."
    fi
    return $updates_snap
}

# ------------------------------------------------------
# Iniciando Actualizaciones
# ------------------------------------------------------

while true; do
    read -p "¿Quieres instalar las actualizaciones? (s/n): " sn
    case $sn in
        [sS]* )
            echo ""
            break;;
        [nN]* ) 
            notify-send "Centro de Actualizaciones:" "Actualización cancelada"
            exit;
            ;;
        * ) echo "Responde usando s o n.";;
    esac
done

echo "-----------------------------------------------------"
echo "Sincronizando la base de datos de paquetes de Arch"
echo "-----------------------------------------------------"
# Actualiza la base de datos de paquetes de Arch
sudo pacman -Sy

echo "-----------------------------------------------------"
echo "Iniciando Actualizaciones"
echo "-----------------------------------------------------"

# Verifica actualizaciones con Pacman (repositorios principales)
updates_pacman=$(checkupdates | wc -l)

if [ "$updates_pacman" -gt 0 ]; then
    echo "Actualizaciones de Pacman disponibles: $updates_pacman"
    read -p "¿Quieres actualizar Pacman? (s/n): " pacman_confirm
    if [[ "$pacman_confirm" =~ [sS] ]]; then
        sudo pacman -Su
        updates_performed=true
        all_updates_skipped=false
    fi
else
    echo "No hay actualizaciones para Pacman."
fi

# Verifica actualizaciones con Yay (repositorios AUR)
updates_yay=$(yay -Qu --aur | wc -l)

if [ "$updates_yay" -gt 0 ]; then
    echo "Actualizaciones de Yay disponibles: $updates_yay"
    read -p "¿Quieres actualizar Yay? (s/n): " yay_confirm
    if [[ "$yay_confirm" =~ [sS] ]]; then
        yay --aur -Syua
        updates_performed=true
        all_updates_skipped=false
    fi
else
    echo "No hay actualizaciones de Yay."
fi

# Actualiza Flatpak si hay actualizaciones
_updateFlatpak
updates_flatpak=$?

# Actualiza Snap si hay actualizaciones
_updateSnap
updates_snap=$?

# ------------------------------------------------------
# Tooltip con información detallada
# ------------------------------------------------------
tooltip=""

if [ "$updates_pacman" -gt 0 ]; then
    tooltip+="Pacman/Yay: $updates_pacman actualizaciones\n"
fi

if [ "$updates_flatpak" -gt 0 ]; then
    tooltip+="Flatpak: $updates_flatpak actualizaciones\n"
fi

if [ "$updates_snap" -gt 0 ]; then
    tooltip+="Snap: $updates_snap actualizaciones\n"
fi

# Si no hay actualizaciones, poner un mensaje por defecto en el tooltip
if [ -z "$tooltip" ]; then
    tooltip="No hay actualizaciones pendientes."
fi

# ------------------------------------------------------
# Verifica si no hubo actualizaciones
# ------------------------------------------------------
if [ "$updates_pacman" -eq 0 ] && [ "$updates_yay" -eq 0 ] && [ "$updates_flatpak" -eq 0 ] && [ "$updates_snap" -eq 0 ]; then
    notify-send "Centro de Actualizaciones:" "Nada que hacer"
elif [ "$updates_performed" = true ]; then
    total_updates=$(("$updates_pacman" + "$updates_yay" + "$updates_flatpak" + "$updates_snap"))
    notify-send "Centro de Actualizaciones:" "$total_updates actualizaciones instaladas"
else
    notify-send "Centro de Actualizaciones:" "Actualización cancelada o interrumpida."
fi


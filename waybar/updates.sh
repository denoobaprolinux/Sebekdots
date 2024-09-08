#!/bin/sh

# -----------------------------------------------------
# Requiere pacman-contrib, trizen, flatpak, snapd
# -----------------------------------------------------

# Umbrales para colores del ícono
threshhold_green=1
threshhold_yellow=25
threshhold_red=50

# -----------------------------------------------------
# Verifica actualizaciones de Pacman y AUR (trizen)
# -----------------------------------------------------

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l); then
    updates_arch=0
fi

if ! updates_aur=$(trizen -Su --aur --quiet | wc -l); then
    updates_aur=0
fi

# -----------------------------------------------------
# Verifica actualizaciones de Flatpak y Snap
# -----------------------------------------------------

# Comprueba si Flatpak está instalado
if command -v flatpak > /dev/null 2>&1; then
    if ! updates_flatpak=$(flatpak update --assumeyes | grep -c 'Update:'); then
        updates_flatpak=0
    fi
else
    updates_flatpak=0
fi

# Comprueba si Snap está instalado
if command -v snap > /dev/null 2>&1; then
    if ! updates_snap=$(snap refresh --list | wc -l); then
        updates_snap=0
    fi
else
    updates_snap=0
fi

# -----------------------------------------------------
# Suma todas las actualizaciones
# -----------------------------------------------------

total_updates=$(("$updates_arch" + "$updates_aur" + "$updates_flatpak" + "$updates_snap"))

# -----------------------------------------------------
# Define la clase CSS según el umbral
# -----------------------------------------------------

if [ "$total_updates" -ge $threshhold_red ]; then
    css_class="red"
elif [ "$total_updates" -ge $threshhold_yellow ]; then
    css_class="yellow"
elif [ "$total_updates" -ge $threshhold_green ]; then
    css_class="green"
else
    css_class="white"
fi

# -----------------------------------------------------
# Tooltip detallado
# -----------------------------------------------------

tooltip=""
if [ "$updates_arch" -gt 0 ] || [ "$updates_aur" -gt 0 ]; then
    tooltip+="Pacman/Yay: $(("$updates_arch" + "$updates_aur")) actualizaciones\n"
fi

if [ "$updates_flatpak" -gt 0 ]; then
    tooltip+="Flatpak: $updates_flatpak actualizaciones\n"
fi

if [ "$updates_snap" -gt 0 ]; then
    tooltip+="Snap: $updates_snap actualizaciones\n"
fi

# -----------------------------------------------------
# Salida en formato JSON para Waybar
# -----------------------------------------------------

if [ "$total_updates" -gt 0 ]; then
    printf '{"text": "%s", "alt": "%s", "tooltip": "%s", "class": "%s"}' "$total_updates" "$total_updates" "$tooltip" "$css_class"
else
    printf '{"text": "0", "alt": "0", "tooltip": "Sin actualizaciones", "class": "white"}'
fi

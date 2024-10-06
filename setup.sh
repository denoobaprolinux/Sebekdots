#!/bin/bash

# Función para hacer un respaldo de ~/.config
backup_config() {
    BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
    echo "Creando respaldo de ~/.config en $BACKUP_DIR"
    cp -r $HOME/.config $BACKUP_DIR
    echo "Respaldo completado."
}

# Paso 1: Preguntar al usuario si desea hacer un respaldo de ~/.config
echo "¿Deseas hacer un respaldo de la carpeta ~/.config antes de sobrescribir? (S/n)"
read -r backup_choice

if [[ $backup_choice == "S" || $backup_choice == "s" || $backup_choice == "" ]]; then
    backup_config
else
    echo "No se hará el respaldo."
fi

# Paso 2: Instalar cmake
sudo pacman -S cmake --noconfirm

# Paso 3: Instalar Yay (el usuario elige entre la opción 1 o 2)
echo "Selecciona una opción para instalar Yay:"
echo "1) Instalar yay (recomendado)"
echo "2) Instalar yay-bin"
read -p "Elige [1/2]: " choice

if [ "$choice" == "1" ]; then
    # Opción 1: Instalar Yay desde el repositorio oficial de AUR
    sudo pacman -S --needed git base-devel --noconfirm
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
elif [ "$choice" == "2" ]; then
    # Opción 2: Instalar Yay desde el repositorio binario
    sudo pacman -S --needed git base-devel --noconfirm
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si
    cd ..
else
    echo "Opción inválida, abortando instalación."
    exit 1
fi

# Paso 4: Instalar Chaotic-AUR
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

# Añadir Chaotic-AUR al archivo pacman.conf
echo "[chaotic-aur]" | sudo tee -a /etc/pacman.conf
echo "Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf

# Paso 5: Clonar Sebekdots
git clone https://github.com/andrewsebek/Sebekdots.git

# Paso 6: Instalar Dependencias
sudo pacman -S waybar nwg-look nwg-menu nwg-drawer rofi-wayland swww grim swappy slurp \
network-manager-applet pacman-contrib trizen blueman kooha udiskie python-pywal yad --noconfirm
yay -S hyprlock swayosd-git swaync-git --noconfirm

# Paso 7: Habilitar plugins en Hyprland y activar hyprexpo
sudo pacman -S cpio meson --noconfirm
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm enable hyprexpo

# Paso 8: Crear carpetas para wallpapers
mkdir -p /home/$USER/Imágenes/Wallpapers/Set

# Paso 9: Descomprimir fuentes y colocarlas en la carpeta correcta
unzip neuropolitical.zip -d /home/$USER/.local/share/fonts/
unzip Iosevka.zip -d /home/$USER/.local/share/fonts/
unzip fast_hand.zip -d /home/$USER/.local/share/fonts/

# Paso 10: Instalar fuentes
fc-cache -f -v

# Paso 11: Copiar carpetas de configuración desde Sebekdots (sobreescribe el contenido en ~/.config)
cp -r Sebekdots/hypr Sebekdots/kitty Sebekdots/nwg-panel Sebekdots/rofi Sebekdots/sncabajo \
Sebekdots/sncarriba Sebekdots/wal Sebekdots/waybar /home/$USER/.config

# Paso 12: Asignar permisos de ejecución a scripts
chmod +x /home/$USER/.config/waybar/*.sh
chmod +x /home/$USER/.config/waybar/themes/themeswitcher.sh
chmod +x /home/$USER/.config/hypr/*.sh

# Paso 13: Ejecutar el script wallpaper.sh
cd /home/$USER/.config/waybar
./wallpaper.sh

# Paso 14: Cargar Waybar con el atajo Super + Shift + Q
echo "Carga Waybar con el atajo Super + Shift + Q"

# Paso 15: Usar el botón de Cambio de Tema en Waybar para seleccionar un tema
echo "Usa el botón de 'Cambiar Tema de Waybar' para seleccionar un tema, o"
echo "Presiona la combinación de teclas Súper + Shift + B"


# Paso 16: Descomprimir íconos y moverlos a ~/.icons
tar -xvf candy-icons.tar.xz -C /home/$USER/.icons

# Paso 17: Seleccionar los íconos en GTK Settings
echo "Recuerda abrir 'GTK Settings' y seleccionar el paquete de íconos."

# Paso 18: Habilitar servicio swayosd-libinput-backend.service
sudo systemctl enable --now swayosd-libinput-backend.service

echo "Instalación completa. ¡Disfruta Sebekdots!"


![swappy-20240409_220803](https://github.com/andrewsebek/sebekdots-2.1/assets/121652305/8b037fcc-761f-4a45-82da-c20d7f6fe010)
_Apariencia general de Hyprland con Sebekdots 2.1.1_

# Sebekdots 2.1.1

He vuelto con una actualización en mis dotfiles, básicamente añadiendo par de funcionalidades: un centro de energía completo en Sway Notification Center, y Hyprexpo, un plugin desarrollado por Vaxry para mostrar todos los espacios de trabajo "at glance", similar a como muestra la información Gnome o Plasma (activado en mis dotfiles usando la tecla Super + A), aparte de una nueva fuente para Waybar, llamada "Neuropolitical". También ha sido mejorada la velocidad en las transiciones, en la apertura y cierre de los programas, los efectos visuales en general, añadido el efecto "dim" para la ventanas activas e inactivas (100% para las activas y 70% para las inactivas) y han sido eliminados los bordes coloridos... Realmente sólo cambié los parámetros en las líneas de código, y si aún los quieres, cambia esos parámetros en hypr.conf:

- 43    border_size = 0 (estaba originalmente en 2)
- 80    drop_shadow = no (originalmente en yes)

Con esas dos modificaciones, vuelven las visuales del borde (colores rotativos basados en el wallpaper con el script de Pywal) y la luz neón detrás de cada ventana (también con el script de Pywal)

# Importante, MUY importante

Para que funcione el plugin "Hyprexpo" debes usar la versión git de Hyprland, hyprland-git, y se instala desde AUR. Si no quieres usar esa funcionalidad, basta con que elimines o comentes la primera línea de código de hypr.conf:

`exec-once = hyprpm enable hyprexpo`

Varxy tiene planificado hacer que este plugin funcione en la actualización de Hyprland 0.38, así que por los momentos, hyprland-git es la opción elegida.

**Instrucciones acerca de cómo habilitar el repositorio de plugins y hyprexpo en mi último video**

![swappy-20240409_221231](https://github.com/andrewsebek/sebekdots-2.1/assets/121652305/11e4978b-4fb7-4346-8dd9-9dfa5a086617)
_Vista previa de hyprexpo_

# Dependencias

- nwg-menu
- swaync (SwayNotificationCenter)
- rofi
- pywal
- swww
- grim
- swappy
- slurp
- nm-applet
- gtklock (comentado en hypr.conf)
- kyprlock (instrucciones de instalación y configuración: https://youtu.be/0mCxxQQQdO4)
- trizen
- NetworkManager
- blueman
- kooha (herramienta muy sencilla para captura de pantalla)

# Fuente "Neuropolitical"

https://www.dafont.com/neuropolitical.font 
Incluyo el archivo .zip en mi repositorio para descarga

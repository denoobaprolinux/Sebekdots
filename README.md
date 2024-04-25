
![swappy-20240424_015530](https://github.com/andrewsebek/Sebekdots/assets/121652305/bb865eeb-dc97-46ce-aa64-9b6ba5f590d0)
_Apariencia general de Hyprland con Sebekdots 2.2-HE_

# Sebekdots 2.2-HE (Hyprland Edition) - Viene de la versión 2.1.1

He vuelto con una actualización en mis dotfiles, básicamente añadiendo par de funcionalidades: un centro de energía completo en Sway Notification Center, y Hyprexpo, un plugin desarrollado por Vaxry para mostrar todos los espacios de trabajo "at glance", similar a como muestra la información Gnome o Plasma (activado en mis dotfiles usando la tecla Super + A), aparte de una nueva fuente para Waybar, llamada "Neuropolitical". También ha sido mejorada la velocidad en las transiciones, en la apertura y cierre de los programas, los efectos visuales en general, añadido el efecto "dim" para la ventanas activas e inactivas (100% para las activas y 70% para las inactivas) y han sido eliminados los bordes coloridos... Realmente sólo cambié los parámetros en las líneas de código, y si aún los quieres, cambia esos parámetros en hypr.conf:

- 43    border_size = 0 (estaba originalmente en 2)
- 80    drop_shadow = no (originalmente en yes)

Con esas dos modificaciones, vuelven las visuales del borde (colores rotativos basados en el wallpaper con el script de Pywal) y la luz neón detrás de cada ventana (también con el script de Pywal)

### Cambios específicos introducidos en V.2.2-HE

- Corrección del tema "Modular" (ambos): desaparecieron los píxeles muertos en esos temas
- El **área de notificaciones** sigue a la barra: todos los temas "arriba" tienen las notificaciones *arriba* y de igual modo, con todos los temas "abajo" (notificaciones abajo)
- El **Widget de Energía** del Centro de Notificaciones sigue el mismo patrón que el área de notificaciones, pegados a la barra siempre, no importa qué tema elijas
- Colores unificados en el menú, las barras con gradientes negros, y el Centro de Notificaciones
- Click derecho sobre el selector de wallpapers, genera un wallpaper al azar

## Importante, MUY importante (ACTUALIZACIÓN)

*YA NO NECESITAS USAR HYPRLAND-GIT*

Actualmente "hyprexpo" es funcional en la rama estable de Hyprland. Si instalaste hyprland-git, para revertir el cambio sencillamente usa "sudo pacman -S hyprland" y vuelves a la versión estable, así nada más. Si no quieres usar hyprexpo (o ningún otro plugin), basta con que elimines o comentes la primera línea de código de hyprland.conf:

`exec-once = hyprpm reload -n`

Asimismo, comenta o elimina la línea 145:

`bind = $mainMod, A, hyprexpo:expo, toggle # puede ser: toggle (alternar entre mostrar/ocultar), off(deshabilitar) u on(habilitar)`

Y con esto, ya no deberías tener activa la función hyprexpo ni la carga de plugins por Hyprland.

**Instrucciones acerca de cómo habilitar el repositorio de plugins y hyprexpo [en este video](https://youtu.be/JLkzIY-xrjg?si=PtNIM7v-lKrw5rzc)**

![swappy-20240424_015601](https://github.com/andrewsebek/Sebekdots/assets/121652305/ce21f516-5fc6-4c9e-a84b-5e28ecdff990)
_Vista previa de hyprexpo_

## Dependencias

**Van a copiar en una terminal los siguientes comandos:**

### Con pacman:

`sudo pacman -S nwg-menu swaync rofi swww grim swappy slurp network-manager-applet pacman-contrib trizen blueman kooha udiskie`

### Con Yay (AUR helper):

`yay -S hyprlock pywal` (Hyprlock ya está disponible en AUR, y deben instalar la versión normal de Pywal, no la de 16 colores)

Les aconsejo visitar el [repositorio de Hyprlock](https://github.com/hyprwm/hyprlock) por si necesitan la lista de dependencias para instalar este software (deberían instalarse junto a Hyprlock)

# Fuente "Neuropolitical"

https://www.dafont.com/neuropolitical.font 
Incluyo el archivo .zip en mi repositorio para descarga

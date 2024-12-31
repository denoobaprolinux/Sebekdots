[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://paypal.me/hyprsebek?country.x=TT&locale.x=en_US)

¡Si te gusta este proyecto, considera donar!

Sería de muchísima utilidad para seguir desarrollando software

Gracias ;)

**Sebek**

# ¡Sebekdots 3.6-RC1 ya está aquí!

![Hyprland_2024-12-31_04 25 49](https://github.com/user-attachments/assets/0169a992-291a-4129-a1a4-a2b95537babc)
_Widget de Audio_

![Hyprland_2024-12-31_04 26 05](https://github.com/user-attachments/assets/714a1357-4f23-404c-b706-e93a2bb5ed8c)
_Waypaper como interfaz para cambiar wallpapers_

![Hyprland_2024-12-31_04 26 30](https://github.com/user-attachments/assets/dc6f5b18-488d-43ee-9ff8-28783643e757)
_Nuevo GUI para el Portapapeles, nwg-clipman_

Demo completo [en este enlace](https://www.youtube.com/watch?v=K7w-nsaZU3w)

## ¡Nueva edición de Sebekdots para Hyprland!

Actualizaciones acumulativas a mis dotfiles, con la siguiente lista de cambios:

1. Widget de audio disponible para todas las barras horizontales (No hay necesidad de colocarlo en las verticales, porque hay acceso a un widget de audio en el Centro de Notificaciones)

2. Waypaper ahora es el nuevo software para gestionar wallpapers, pudiendo seleccionar entre swww y hyprpaper. La configuración para hyprpaper está provista en esta actualización

3. Nwg-clipman es el nuevo frontend para manejo del portapapeles.

4. Desaparecen de la configuración una cantidad importante de scripts y el funcionamiento de otros tantos ha sido simplificado para corregir errores y redundancias.

## Importante, MUY importante

*YA NO NECESITAS USAR HYPRLAND-GIT*

Desde Sebekdots 3.2 los dotfiles usan hyprexpo, y si no lo instalas, va a salir una tira roja con un mensaje de error que no desaparecerá hasta que edites hyprland.conf. Si no quieres usar hyprexpo (o ningún otro plugin), basta con que elimines o comentes la línea 20 del código de hyprland.conf:

`exec-once = hyprpm reload`

Asimismo, comenta o elimina la línea 10 de keybindings.conf:

`bind = $mainMod, TAB, hyprexpo:expo, toggle # puede ser: toggle (alternar entre mostrar/ocultar), off(deshabilitar) u on(habilitar)`

Y con esto, ya no deberías tener activa la función hyprexpo ni la carga de plugins por Hyprland.

**Instrucciones acerca de cómo habilitar el repositorio de plugins y hyprexpo [en este video](https://youtu.be/JLkzIY-xrjg?si=PtNIM7v-lKrw5rzc)**


![Hyprland_2024-10-06_06 51 43](https://github.com/user-attachments/assets/bc970e03-21a4-4867-a93b-01cae57104c4)
_Vista previa de hyprexpo_

## Pasos para instalar Sebekdots

Visita la [Wiki](https://github.com/andrewsebek/Sebekdots/wiki)

# Fuente "Neuropolitical"

https://www.dafont.com/neuropolitical.font 
Incluyo el archivo .zip en mi repositorio para descarga

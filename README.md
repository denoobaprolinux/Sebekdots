# Sebekdots 3.4 Hyprland Edition

![Hyprland_2024-09-08_17 26 54](https://github.com/user-attachments/assets/466e8bad-f700-418c-aeb8-a96b450d9420)
![Hyprland_2024-09-08_17 26 45](https://github.com/user-attachments/assets/5eb85dcf-14ab-4a7f-b14c-ae168c6045bc)
![Hyprland_2024-09-08_17 26 37](https://github.com/user-attachments/assets/816e1bd9-f171-4fe2-af76-5575e0de73d2)
_Nuevo tema "Vertical"_

![Hyprland_2024-09-02_13 34 11](https://github.com/user-attachments/assets/f4975d2e-58a0-44c9-af5d-d86788110d9a)
_Nuevos temas "Powerline" disponibles_

¡Nueva edición de Sebekdots para Hyprland!

Actualizaciones acumulativas a mis dotfiles, con la siguiente lista de cambios:

- Los temas "Powerline" (Arriba/Abajo) tienen un nuevo efecto hover en el menú y en el centro de notificaciones
- El script de cambio de Wallpapers ahora permite tener GIFs como fondos de pantalla animados (proveniente de la versión anterior)
- Nuevo tema "Vertical": la barra tiene dos _revealers_ que muestran información cuando le pones el puntero del mouse encima a los iconos de audio y la flecha hacia arriba. Además, vuelve el tema Pac-Man para esta barra, por razones estéticas.
- En todas las barras el script de actualizaciones ha recibido una gran mejora: cuenta actualizaciones pendientes y actualiza pacman/AUR (con yay)/flatpak/snap, y tiene código de colores de acuerdo a la cantidad de actualizaciones (color base, más verde/amarillo/rojo)

**El resto de las configuraciones permanecen iguales**

## Importante, MUY importante

*YA NO NECESITAS USAR HYPRLAND-GIT*

Desde Sebekdots 3.2 los dotfiles usan hyprexpo, y si no lo instalas, va a salir una tira roja con un mensaje de error que no desaparecerá hasta que edites hyprland.conf. Si no quieres usar hyprexpo (o ningún otro plugin), basta con que elimines o comentes la línea 20 del código de hyprland.conf:

`exec-once = hyprpm reload`

Asimismo, comenta o elimina la línea 10 de keybindings.conf:

`bind = $mainMod, TAB, hyprexpo:expo, toggle # puede ser: toggle (alternar entre mostrar/ocultar), off(deshabilitar) u on(habilitar)`

Y con esto, ya no deberías tener activa la función hyprexpo ni la carga de plugins por Hyprland.

**Instrucciones acerca de cómo habilitar el repositorio de plugins y hyprexpo [en este video](https://youtu.be/JLkzIY-xrjg?si=PtNIM7v-lKrw5rzc)**

![swappy-20240424_015601](https://github.com/andrewsebek/Sebekdots/assets/121652305/ce21f516-5fc6-4c9e-a84b-5e28ecdff990)
_Vista previa de hyprexpo_

## Pasos para instalar Sebekdots 3.4

Visita la [Wiki](https://github.com/andrewsebek/Sebekdots/wiki)

# Fuente "Neuropolitical"

https://www.dafont.com/neuropolitical.font 
Incluyo el archivo .zip en mi repositorio para descarga

## Importante

Para que el selector de wallpapers funcione, crea la carpeta "Set" en /Imágenes/Wallpapers/ (tal cual con las mayúsculas) y coloca todos tus wallpapers allí. El selector de wallpapers te los mostrará con Rofi.

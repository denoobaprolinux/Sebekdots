
![Escritorio](https://github.com/andrewsebek/Sebekdots/assets/121652305/3d39763c-5ccc-44d2-a0d5-2c2daba55915)
_Apariencia general de Hyprland con Sebekdots 3.1-HE_

![Configuraciones](https://github.com/andrewsebek/Sebekdots/assets/121652305/6feea2c4-d0af-4273-9ff2-4cf097539b84)
_Nuevo Menú de Configuraciones_

![Temas](https://github.com/andrewsebek/Sebekdots/assets/121652305/9e007541-6ba7-4c61-b1d2-0f08b91985e1)
_Selector de Temas de Waybar_

![Wallpapers](https://github.com/andrewsebek/Sebekdots/assets/121652305/b57a4059-6c6a-4ea5-a688-31a3e16acebd)
_Selector de Wallpapers_

# Sebekdots 3.1-HE (Hyprland Edition)

¡Nueva edición de Sebekdots para Hyprland!

Le he hecho una gran lavada de cara a mis dotfiles a través de Rofi, con los cambios que se ven en las capturas arriba:

- El menú de configuraciones de Hyprland, con muchas más funcionalidades, comportamiento persistente, y adaptado al estilo de mis dotfiles
- El menú de temas de Waybar, más amplio (permite la visualisación de 24 elementos a la vez)
- El menú de selección de wallpapers, ampliado a 32 opciones

Todos los menús de Rofi ahora participan de la paleta de colores generadas por los wallpapers, las barras de búsquedas distinguen mejor el ícono de lupa que aparece, y tienen una descripción en la misma ventana.

**El resto de las configuraciones permanecen iguales**

## Importante, MUY importante

*YA NO NECESITAS USAR HYPRLAND-GIT*

Sebekdots 3.1 usa hyprexpo, y si no lo instalas, va a salir una tira roja con un mensaje de error que no desaparecerá hasta que edites hyprland.conf. Si no quieres usar hyprexpo (o ningún otro plugin), basta con que elimines o comentes la línea 20 del código de hyprland.conf:

`exec-once = hyprpm reload -n`

Asimismo, comenta o elimina la línea 10 de keybindings.conf:

`bind = $mainMod, TAB, hyprexpo:expo, toggle # puede ser: toggle (alternar entre mostrar/ocultar), off(deshabilitar) u on(habilitar)`

Y con esto, ya no deberías tener activa la función hyprexpo ni la carga de plugins por Hyprland.

**Instrucciones acerca de cómo habilitar el repositorio de plugins y hyprexpo [en este video](https://youtu.be/JLkzIY-xrjg?si=PtNIM7v-lKrw5rzc)**

![swappy-20240424_015601](https://github.com/andrewsebek/Sebekdots/assets/121652305/ce21f516-5fc6-4c9e-a84b-5e28ecdff990)
_Vista previa de hyprexpo_

## Pasos para instalar Sebekdots 3

Visita la [Wiki](https://github.com/andrewsebek/Sebekdots/wiki)

# Fuente "Neuropolitical"

https://www.dafont.com/neuropolitical.font 
Incluyo el archivo .zip en mi repositorio para descarga

## Importante

Para que el selector de wallpapers funcione, crea la carpeta "Set" en /Imágenes/Wallpapers/ (tal cual con las mayúsculas) y coloca todos tus wallpapers allí. El selector de wallpapers te los mostrará con Rofi.

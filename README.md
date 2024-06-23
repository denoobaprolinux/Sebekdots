
![swappy-20240623_193732](https://github.com/andrewsebek/Sebekdots/assets/121652305/eda2cf0d-ae0c-469d-9120-4df2b8f02eab)
_Apariencia general de Hyprland con Sebekdots 3-HE_

# Sebekdots 3-HE (Hyprland Edition)

He vuelto con una actualización en mis dotfiles, cambiando detalles y añadiendo funcionalidades: un nuevo botón de "Configuraciones de Hyprland", cambios en el Centro de Notificaciones, cambios en la estructura de código de configuración de Hyprland, lo mismo con Waybar, y dos nuevos temas, "Barras" Arriba/Abajo.

### Cambios específicos introducidos en V.2.2-HE

- **Agregado nuevo tema, "Barras" con sus variantes arriba/abajo**
- El **área de notificaciones** ha sido reestructurada para mantener la coherencia visual en ambas variantes (Arriba/Abajo) 
- El **botón de Configuración de Hyprland** que ejecuta Rofi, y genera un script que no sobreescribe la configuración por defecto de Hyprland, pero que es cargado en cada reinicio, manteniendo tus opciones elegidas.

## Importante, MUY importante

*YA NO NECESITAS USAR HYPRLAND-GIT*

Sebekdots 3 usa hyprexpo, y si no lo instalas, va a salir una tira roja con un mensaje de error que no desaparecerá hasta que edites hyprland.conf. Si no quieres usar hyprexpo (o ningún otro plugin), basta con que elimines o comentes la línea 20 del código de hyprland.conf:

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

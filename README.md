# Sebekdots 3.5.1 Hyprland Edition

![Hyprland_2024-10-04_22 37 04](https://github.com/user-attachments/assets/e4a9b4e6-5977-4d52-8d97-0a269abfb666)
_Nuevo Tema "Powerlink"_

![Hyprland_2024-10-05_20 53 50](https://github.com/user-attachments/assets/62cf2641-f4e9-43cb-a4d0-bffd28d6ea03)
_Nuevo Tema "Powermix" y lista completa de temas para Waybar_

[demo1.webm](https://github.com/user-attachments/assets/dcb778a6-06b4-44c8-92b6-f2d66c413887)
_Menú de Configuraciones de Hyprland y Comportamiento de Ventanas Agrupadas_

[demo2.webm](https://github.com/user-attachments/assets/010e4e65-e4f2-488a-bc21-66ab596f6635)
_Algunos temas de Sebekdots 3.5 y tema de menú de Aplicaciones_

Demo completo [en este enlace](https://www.youtube.com/watch?v=K7w-nsaZU3w)

## ¡Nueva edición de Sebekdots para Hyprland!

Actualizaciones acumulativas a mis dotfiles, con la siguiente lista de cambios:

1. Las ventanas pueden moverse con el teclado
2. Mejorada la característica de las pestañas, ahora las barras de pestañas activas son indicadores luminosos, y participan del esquema de colores del sistema
3. Ahora se puede agregar una ventana a un grupo de pestañas sólo arrastrando la ventana al grupo de pestañas, pero también puede hacerse con keybindings **(Control + Súper + flechas del teclado)**
4. Añadida la característica "volver a espacio de trabajo anterior" con **Alt + Tab** 
5. Las barras ahora participan del efecto Blur: si tienes una barra con transparencia o traslucidez, y activas el efecto Blur en las opciones de Hyprland, la barra también se difumina. Eso ofrece un look and feel adicional a las barras (de manera involuntaria se han creado nuevos temas con esa característica)
6. Eliminada la barra vertical de la actualización anterior: estaba muy descuidada y tosca. En su lugar, se han agregado dos barras verticales, "Degradado" y "Mínima", ambas a la izquierda.
7. Selección aleatoria de wallpapers con **Súper + W.**
8. El script de selección de wallpapers ha sido mejorado para admitir wallpapers animados. Esta mejora viene desde la versión anterior.
9. Todos los temas clásicos han sido retirados. Sólo se conserva un tema clásico, pero ha sido cambiado/reimaginado. Asimismo, los temas "Mínima" han sido mejorados, lo mismo que los temas "Powerline".
10. Han sido agregados nuevos temas: **"Powermix", "Powerlink", "Degradado", "Revealer", y "Transparente" (este último en variantes claro/oscuro)** 
11. Ahora hay un archivo en las configuraciones de Hyprland llamado custom.conf para que puedan poner allí sus configuraciones personales. En la actualización, el archivo va vacío (Sólo con unas instrucciones)
12. Mejorado el script de actualizaciones: detecta si en el sistema están instalados Yay, Flatpak y Snap (Yay sí o sí debe estar instalado para que funcionen los dotfiles) y pide confirmación en cada paso, puedes elegir no actualizar elementos por separado. También, el script envía notificaciones con relación a lo que hace, bien sea la cancelación del proceso por el usuario, o la actualización de los elementos.
13. El módulo de actualizaciones en Waybar se reinicia inmediatamente se termina de ejecutar, de tal manera que vuelve a cero tan pronto se acaba la ejecución del script.
14. Las barras ahora pueden aparecer y desaparecer de la pantalla para permitir una experiencia de pantalla completa. Sólo presiona **Súper + B** y activas/desactivas la barra.
15. Presionando **Súper + A**, aparece una ayuda en pantalla con todos los keybindings (este archivo fue mejorado con respecto al demo)
16. Agregado un efecto "minimizar" con **Súper + S**, que involucra el espacio de trabajo especial: no vas a ver las ventanas allí, sólo se van a almacenar, y aparecen nuevamente en donde desees. Sólo se puede hacer con una sola ventana.
17. He incluido en este repositorio todas las fuentes necesarias, de tal manera que ya no necesitas descargarlas. Solamente con clonar el repositorio y seguir los pasos de la Wiki, podrás hacer la instalación.
18. Si presionas los dos botones de shift al mismo tiempo, cambiarás la distribución del teclado a inglés de Estados Unidos (útil para los que tengan computadoras con distribución del teclado en inglés), y cada barra tiene un indicador del idioma elegido al lado del centro de notificaciones (ESP/ENG). Por defecto, la primera distribución es español latinoamericano.
19. Actualización 3.5.1: Nuevo botón en todas las barras, **portapapeles**. Es el front-end de Cliphist, así que ahora tienes acceso a un portapapeles funcional.

**Próximamente, pondré a disposición de la comunidad un programa para instalar/actualizar los dotfiles.**

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

## Importante

Para que el selector de wallpapers funcione, crea la carpeta "Set" en /Imágenes/Wallpapers/ (tal cual con las mayúsculas) y coloca todos tus wallpapers allí. El selector de wallpapers te los mostrará con Rofi.

<video src="https://github.com/user-attachments/assets/723fc87f-f6b0-4c2a-9a12-8ef3c050cc46"></video>
_Vista previa de Sebekdots 3.2_

![Screenshot_2024-08-07_21 49 02](https://github.com/user-attachments/assets/de47d9fb-12be-42fe-a9db-647a17799a29)
_Sebekdots 3.3 con el menú y el centro de notificaciones abiertos_

![Hyprland_2024-09-02_13 34 11](https://github.com/user-attachments/assets/f4975d2e-58a0-44c9-af5d-d86788110d9a)
_Nuevos temas "Powerline" disponibles_

# Sebekdots 3.3-HE (Hyprland Edition)

¡Nueva edición de Sebekdots para Hyprland!

Actualizaciones acumulativas a mis dotfiles, con la siguiente lista de cambios:

- El menú de configuraciones de Hyprland: añadidas más opciones, para hacer un total de 16 + la configuración por defecto de Sebekdots.
- Todos los temas que derivan de la barra "Clásica" tienen nuevos efectos "hover" en el menú de aplicaciones y en el Centro de Notificaciones
- El Menú de Aplicaciones y el Centro de Notificaciones tienen ahora un borde de 2 pixeles de ancho para delimitarlo en contra del fondo 
- **Grimblast.sh** para captura de pantalla (utilidad hecha con grim y slurp) con combinación de teclas Control + ImpPnt, para generar una notificación de captura de pantalla, guardada en la carpeta /home/user/Imágenes/Capturas (generadas por el script)
- Modificados todos los temas de Waybar **"Completa"** para eliminar las esquinas redondeadas (Ahora todos los temas son planos, para ser consistentes con la posición de las ventanas, y la posible selección de Smart Gaps por el usuario, estéticamente se ve mejor)
- Modificados todos los temas **"Clásico"**: Los visuales de los botones de menú y notificaciones han sido cambiados (ya no tienen borde, pero el borde aparece cuando pasas por encima de los botones con el mouse, y las notificaciones ahora son más llamativas en la barra, así mismo el estilo de la función "no molestar" es congruente con los cambios)
- Correcciones menores en algunos temas, que tenían errores de formato.
- Nueva animación **"Desvanecer"**: imita la clásica animación de Picom en la gran mayoría de los TWM en X11 (tomé inspiración de rices hechos en bspwm) donde las ventanas sencillamente se desvanecen al cambiar de espacios de trabajo, y con una ligera animación de apertura y cierre de las ventanas. Es la animación más fluida que he programado, porque es la que menos recursos gráficos consume.
- Nuevo modo **"Pestañas"**: ahora las ventanas pueden ser agrupadas en pestañas en un mismo espacio de trabajo con la combinación de teclas Super + Shift + T
- Modo de **"pantalla completa"**: Puedes hacer que una ventana ocupe todo el espacio de trabajo de manera temporal, sin cerrar otra(s) ventana(s), solamente pulsando Super + D
- Incorporación de **Indicadores en Pantalla (OSD - On Screen Display)**: Ahora, presionar NumLock/CapsLock/ScrollLock, subir/bajar volumen, y subir/bajar brillo de pantalla, generan una visualización en pantalla generada por **swayosd**
- **Cambiada la combinación de teclas para recargar Waybar**: ahora es Super + Shift + R (más intuitivo)
- **Agregada combinación de teclas para activar hyprctl.sh**: si por alguna razón hyprctl.sh no carga (cosa que no me ha pasado ni una sola vez), si presionas Super + Shift + H se carga el script y todas las opciones personalizadas elegidas por ti. Esto puede sucederte si modificas alguna línea de código de Hyprland (y por eso hice el script)

### Actualización 3.3.1

- Los temas "Modular" han sido removidos. La razón: una geometría difícil de conciliar con mis dotfiles, además de ocupar muchísimo espacio en pantalla.
- Cambiados los temás "Mínima", con nuevas animaciónes.
- TODOS los temas ahora tienen transiciones suaves en el efecto "hover" en TODOS los botones.
- Swaync removido, para usar Swaync-git (la versión actualizada por Erik Reider, el creador del software) para corregir el error de los widgets de MPRIS duplicados en el Centro de Notificaciones (Temporal, cuando el cambio sea subido a la rama estable, lo revertiré)

### Actualización 3.3.2

- Tema nuevo para Waybar - "Powerline" (Arriba/Abajo)
- El script de cambio de Wallpapers ahora permite tener GIFs como fondos de pantalla animados

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

## Pasos para instalar Sebekdots 3.3

Visita la [Wiki](https://github.com/andrewsebek/Sebekdots/wiki)

# Fuente "Neuropolitical"

https://www.dafont.com/neuropolitical.font 
Incluyo el archivo .zip en mi repositorio para descarga

## Importante

Para que el selector de wallpapers funcione, crea la carpeta "Set" en /Imágenes/Wallpapers/ (tal cual con las mayúsculas) y coloca todos tus wallpapers allí. El selector de wallpapers te los mostrará con Rofi.

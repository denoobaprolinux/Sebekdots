# Shell variables
# Generated by 'Matugen'
wallpaper="{{image}}"

# Special
background='{{colors.background.default.hex}}'
foreground='{{colors.on_surface.default.hex}}'
cursor='{{colors.on_surface.default.hex}}'

# Colors
color0='{{colors.background.default.hex}}'   # Fondo base
color1='{{colors.error.default.hex}}'        # Rojo (Errores, advertencias)
color2='{{colors.primary.default.hex}}'      # Verde (Éxito, selecciones)
color3='{{colors.secondary.default.hex}}'    # Amarillo (Indicadores)
color4='{{colors.tertiary.default.hex}}'     # Azul (Resaltado)
color5='{{colors.on_surface_variant.default.hex}}'  # Magenta (Sombra, elementos neutros)
color6='{{colors.outline.default.hex}}'      # Cian (Líneas de borde)
color7='{{colors.on_background.default.hex}}' # Texto sobre fondo oscuro
color8='{{colors.surface_variant.default.hex}}'  # Gris oscuro
color9='{{colors.error_container.default.hex}}'  # Rojo claro (Fondos de alerta)
color10='{{colors.primary_fixed_dim.default.hex}}' # Verde claro (Fondos destacados)
color11='{{colors.secondary_fixed_dim.default.hex}}' # Amarillo claro (Fondos suaves)
color12='{{colors.tertiary_fixed_dim.default.hex}}' # Azul claro (Fondo seleccionado)
color13='{{colors.on_primary.default.hex}}' # Magenta claro (Texto destacado)
color14='{{colors.on_secondary.default.hex}}' # Cian claro (Texto alternativo)
color15='{{colors.inverse_on_surface.default.hex}}' # Texto claro sobre fondos oscuros

# FZF colors
export FZF_DEFAULT_OPTS="
    $FZF_DEFAULT_OPTS
    --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
    --color info:7,prompt:2,spinner:1,pointer:232,marker:1
"

# Fix LS_COLORS being unreadable.
export LS_COLORS="${LS_COLORS}:su=30;41:ow=30;42:st=30;44:"

#!/usr/bin/env bash
## Grimblast: a helper for screenshots within hyprland
## Requirements:
##  - `grim`: screenshot utility for wayland
##  - `slurp`: to select an area
##  - `hyprctl`: to read properties of current window (provided by Hyprland)
##  - `hyprpicker`: to freeze the screen when selecting area
##  - `wl-copy`: clipboard utility (provided by wl-clipboard)
##  - `jq`: json utility to parse hyprctl output
##  - `notify-send`: to show notifications (provided by libnotify)
## Those are needed to be installed, if unsure, run `grimblast check`
##
## See `man 1 grimblast` or `grimblast usage` for further details.

## Author: Misterio (https://github.com/misterio77)

## This tool is based on grimshot, with swaymsg commands replaced by their
## hyprctl equivalents.
## https://github.com/swaywm/sway/blob/master/contrib/grimshot
getTargetDirectory() {
  test -f "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs" &&
    . "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"

  echo "${XDG_SCREENSHOTS_DIR:-${XDG_PICTURES_DIR:-$HOME}}"
}

tmp_editor_directory() {
  echo "/tmp"
}

#Detect if $GRIMBLAST_EDITOR env exist
env_editor_confirm() {
  if [ -n "$GRIMBLAST_EDITOR" ]; then
    echo "GRIMBLAST_EDITOR is set. Continuing..."
  else
    echo "GRIMBLAST_EDITOR is not set. Defaulting to gimp"
    GRIMBLAST_EDITOR=gimp
  fi
}

NOTIFY=yes
CURSOR=
FREEZE=
WAIT=no
SCALE=
HYPRPICKER_PID=-1

while [ $# -gt 0 ]; do
  key="$1"

  case $key in
  -n | --notify)
    NOTIFY=yes
    shift # past argument
    ;;
  -c | --cursor)
    CURSOR=yes
    shift # past argument
    ;;
  -f | --freeze)
    FREEZE=yes
    shift # past argument
    ;;
  -w | --wait)
    shift
    WAIT=$1
    if echo "$WAIT" | grep "[^0-9]" -q; then
      echo "Invalid value for wait '$WAIT'" >&2
      exit 3
    fi
    shift
    ;;
  -s | --scale)
    shift # past argument
    if [ $# -gt 0 ]; then
      SCALE="$1" # assign the next argument to SCALE
      shift      # past argument
    else
      echo "Error: Missing argument for --scale option."
      exit 1
    fi
    ;;
  *)      # unknown option
    break # done with parsing --flags
    ;;
  esac
done

ACTION=${1:-usage}
SUBJECT=${2:-screen}
FILE=${3:-$(getTargetDirectory)/$(date -Ins).png}
FILE_EDITOR=${3:-$(tmp_editor_directory)/$(date -Ins).png}

if [ "$ACTION" != "save" ] && [ "$ACTION" != "copy" ] && [ "$ACTION" != "edit" ] && [ "$ACTION" != "copysave" ] && [ "$ACTION" != "check" ]; then
  echo "Uso:"
  echo "  grimblast [--notify] [--cursor] [--freeze] [--wait N] [--scale <scale>] (copy|save|copysave|edit) [active|screen|output|area] [FILE|-]"
  echo "  grimblast check"
  echo "  grimblast usage"
  echo ""
  echo "Comandos:"
  echo "  copy: Copia la captura de pantalla en el portapapeles."
  echo "  save: Salva la captura de pantalla a un archivo o '-' para hacerle pipe a STDOUT."
  echo "  copysave: Combina las dos opciones anteriores."
  echo "  edit: Abre la captura de pantalla en un editor de imágenes (gimp por defecto)."
  echo "  check: Verifica que las dependencias estén instaladas."
  echo "  usage: Muestra este mensaje."
  echo ""
  echo "Objetivos:"
  echo "  active: Ventana activa."
  echo "  screen: Toda la pantalla."
  echo "  output: Salida actual."
  echo "  area: Seleccionar manualmente el área."
  exit
fi

notify() {
  notify-send -t 3000 -a grimblast "$@"
}

notifyOk() {
  [ "$NOTIFY" = "no" ] && return

  notify "$@"
}

notifyError() {
  if [ $NOTIFY = "yes" ]; then
    TITLE=${2:-"Screenshot"}
    MESSAGE=${1:-"Error taking screenshot with grim"}
    notify -u critical "$TITLE" "$MESSAGE"
  else
    echo "$1"
  fi
}

resetFade() {
  if [[ -n $FADE && -n $FADEOUT ]]; then
    hyprctl keyword animation "$FADE" >/dev/null
    hyprctl keyword animation "$FADEOUT" >/dev/null
  fi
}

killHyprpicker() {
  if [ ! $HYPRPICKER_PID -eq -1 ]; then
    kill $HYPRPICKER_PID
  fi
}

die() {
  killHyprpicker
  MSG=${1:-Bye}
  notifyError "Error: $MSG"
  exit 2
}

check() {
  COMMAND=$1
  if command -v "$COMMAND" >/dev/null 2>&1; then
    RESULT="OK"
  else
    RESULT="NOT FOUND"
  fi
  echo "   $COMMAND: $RESULT"
}

takeScreenshot() {
  FILE=$1
  GEOM=$2
  OUTPUT=$3
  if [ -n "$OUTPUT" ]; then
    grim ${CURSOR:+-c} ${SCALE:+-s "$SCALE"} -o "$OUTPUT" "$FILE" || die "Unable to invoke grim"
  elif [ -z "$GEOM" ]; then
    grim ${CURSOR:+-c} ${SCALE:+-s "$SCALE"} "$FILE" || die "Unable to invoke grim"
  else
    grim ${CURSOR:+-c} ${SCALE:+-s "$SCALE"} -g "$GEOM" "$FILE" || die "Unable to invoke grim"
    resetFade
  fi
}

wait() {
  if [ "$WAIT" != "no" ]; then
    sleep "$WAIT"
  fi
}

if [ "$ACTION" = "check" ]; then
  echo "Revisando que todas las dependencias estén instaladas. Si no lo están, instala y haz que sean accesibles al PATH..."
  check grim
  check slurp
  check hyprctl
  check hyprpicker
  check wl-copy
  check jq
  check notify-send
  exit
elif [ "$SUBJECT" = "active" ]; then
  wait
  FOCUSED=$(hyprctl activewindow -j)
  GEOM=$(echo "$FOCUSED" | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
  APP_ID=$(echo "$FOCUSED" | jq -r '.class')
  WHAT="$APP_ID window"
elif [ "$SUBJECT" = "screen" ]; then
  wait
  GEOM=""
  WHAT="Screen"
elif [ "$SUBJECT" = "output" ]; then
  wait
  GEOM=""
  OUTPUT=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true)' | jq -r '.name')
  WHAT="$OUTPUT"
elif [ "$SUBJECT" = "area" ]; then
  if [ "$FREEZE" = "yes" ] && [ "$(command -v "hyprpicker")" ] >/dev/null 2>&1; then
    hyprpicker -r -z &
    sleep 0.2
    HYPRPICKER_PID=$!
  fi

  # get fade & fadeOut animation and unset it
  # this removes the black border seen around screenshots
  FADE="$(hyprctl -j animations | jq -jr '.[0][] | select(.name == "fade") | .name, ",", (if .enabled == true then "1" else "0" end), ",", (.speed|floor), ",", .bezier')"
  FADEOUT="$(hyprctl -j animations | jq -jr '.[0][] | select(.name == "fadeOut") | .name, ",", (if .enabled == true then "1" else "0" end), ",", (.speed|floor), ",", .bezier')"
  hyprctl keyword animation 'fade,0,1,default' >/dev/null
  hyprctl keyword animation 'fadeOut,0,1,default' >/dev/null

  WORKSPACES="$(hyprctl monitors -j | jq -r 'map(.activeWorkspace.id)')"
  WINDOWS="$(hyprctl clients -j | jq -r --argjson workspaces "$WORKSPACES" 'map(select([.workspace.id] | inside($workspaces)))')"
  # shellcheck disable=2086 # if we don't split, spaces mess up slurp
  GEOM=$(echo "$WINDOWS" | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp $SLURP_ARGS)

  # Check if user exited slurp without selecting the area
  if [ -z "$GEOM" ]; then
    killHyprpicker
    resetFade
    exit 1
  fi
  WHAT="Area"
  wait
elif [ "$SUBJECT" = "window" ]; then
  die "Subject 'window' is now included in 'area'"
else
  die "Unknown subject to take a screen shot from" "$SUBJECT"
fi

if [ "$ACTION" = "copy" ]; then
  takeScreenshot - "$GEOM" "$OUTPUT" | wl-copy --type image/png || die "Clipboard error"
  notifyOk "$WHAT Copiada al Portapapeles"
elif [ "$ACTION" = "save" ]; then
  if takeScreenshot "$FILE" "$GEOM" "$OUTPUT"; then
    TITLE="Captura de Pantalla"
    MESSAGE=$(basename "$FILE")
    notifyOk "$TITLE" "$MESSAGE" -i "$FILE"
    echo "$FILE"
  else
    notifyError "EError tomando captura con grim"
  fi
elif [ "$ACTION" = "edit" ]; then
  env_editor_confirm
  if takeScreenshot "$FILE_EDITOR" "$GEOM" "$OUTPUT"; then
    TITLE="Captura de Pantalla de $SUBJECT"
    MESSAGE="Abriendo imagen en editor"
    notifyOk "$TITLE" "$MESSAGE" -i "$FILE_EDITOR"
    $GRIMBLAST_EDITOR "$FILE_EDITOR"
    echo "$FILE_EDITOR"
  else
    notifyError "Error tomando captura"
  fi
else
  if [ "$ACTION" = "copysave" ]; then
    takeScreenshot - "$GEOM" "$OUTPUT" | tee "$FILE" | wl-copy --type image/png || die "Clipboard error"
    notifyOk "Imagen Copiada al Portapapeles y Guardada en $FILE" -i "$FILE"
    echo "$FILE"
  else
    notifyError "Error tomando captura con grim"
  fi
fi

killHyprpicker

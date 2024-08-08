#!/bin/bash
 
# ----------------------------------------------------- 
# Requerido: yay trizen 
# ----------------------------------------------------- 

sleep 1
clear

cat <<"EOF"
    _        _               _ _               _                       
   / \   ___| |_ _   _  __ _| (_)______ _  ___(_) ___  _ __   ___  ___ 
  / _ \ / __| __| | | |/ _` | | |_  / _` |/ __| |/ _ \| '_ \ / _ \/ __|
 / ___ \ (__| |_| |_| | (_| | | |/ / (_| | (__| | (_) | | | |  __/\__ \
/_/   \_\___|\__|\__,_|\__,_|_|_/___\__,_|\___|_|\___/|_| |_|\___||___/                      

EOF

_isInstalledYay() {
    package="$1";
    check="$(yay -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

# ------------------------------------------------------
# Iniciando Actualizaciones
# ------------------------------------------------------

while true; do
    read -p "¿Quieres instalar las actualizaciones? (s/n): " sn
    case $sn in
        [s]* )
            echo ""
        break;;
        [n]* ) 
            exit;
        break;;
        * ) echo "Responde usando s o n.";;
    esac
done

echo "-----------------------------------------------------"
echo "Iniciando Actualizaciones"
echo "-----------------------------------------------------"
echo ""

yay

notify-send "Actualizaciones Instaladas"

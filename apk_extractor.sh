#!/bin/bash

# COLORS #
BRED="\e[1;31m"
BGREEN="\e[1;32m"
BYELLOW="\e[1;33m"
NC="\e[0m"

####################
# ANDROID commands #
####################

# Extract apk
# input: name to grep
# input2: outpute apk name
function getapk() {
        if [ "$#" -ne 2 ]; then
                echo "Usage: getapk <name to grep> <output name>";
                return
        fi

        if [ -f $2 ]; then
                echo -e "$BRED[-]$NC File $2 exist"
                return
        fi

        out=$2
        pack="$(getapk-package $1)"
        if echo $pack | grep -iq "error"; then
                echo -e "$BRED[-]$NC getapk-package() - Package not found"
                return
        fi

        path="$(getapk-path $pack)"
        if echo $path | grep -iq "error"; then
                echo -e "$BRED[-]$NC getapk-path() - Path not found"
                return
        fi

        echo -e "$BGREEN[+]$NC Extract APK:\n\tPackage: $pack\n\tPATH: $path"
        adb pull $path $out
}


# Get package name
# input: name to search by grep command
function getapk-package() {
        if [ "$#" -ne 1 ]; then
                echo "Usage: getapk-package <name to grep>"
                return
        fi

        local package=$(adb shell pm list packages | grep -i $1;)

        if ! echo $package | grep -qi $1; then
                echo -e "$BRED[-] ERROR:$NC Package not found"
                return
        fi
        if [[ $(echo $package | awk -F' ' '{print NF}') -gt 1 ]]; then
                echo -e "$BYELLOW[!]$NC Many packages. Choose one:" > $(tty)
                i=0
                for p in $package; do 
                        ((i++))
                        echo "($i) $(echo $p | cut -d ':' -f2)" > $(tty)
                done
                echo
                read -p "Package: " package
                echo $package
        else
                echo $package | cut -d ':' -f 2
        fi
}

# Get path of the package on the device
# input: package name
function getapk-path() {
        if [ "$#" -ne 1 ]; then
                echo "Usage: getapk-path <package name>"
                return
        fi

        local packpath=$(adb shell pm path $1)

        if ! [[ $packpath ]]; then
                echo -e "$BRED[-]$NC Package not found"
                return
        fi

        echo $packpath | cut -d ':' -f 2


}


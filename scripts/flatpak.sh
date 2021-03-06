#!/bin/sh

if [ ! -x "$(command -v flatpak)" >/dev/null 2>&1 ];
then
    echo "Setting up flatpak";
    if [ -r /etc/os-release ];
    then
        . /etc/os-release
        if [ $ID = debian ] || [ $ID = ubuntu ];
        then
            sudo apt install flatpak flatpak-builder;
        else
            echo -e "\e[35mNot on Debian based distros\e[0m";
            echo "Use your package manager to install 'Flatpak'"
            exit;
        fi
    fi

    RET=1;
    until [ ${RET} -eq 0 ]; do
        flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
        echo "";
        read -p "Enter Sdk/runtime version [Ex: 3.28]: " ver;
        flatpak --user install flathub org.gnome.Sdk//$ver;
        flatpak --user install flathub org.gnome.Platform//$ver;
        RET=$?;
    done;
else
    echo -e "\e[32mFlatpak already installed\e[0m";
fi


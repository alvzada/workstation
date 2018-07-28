#!/bin/sh

if [ ! -x "$(command -v flatpak)" >/dev/null 2>&1 ];
then
    echo "Setting up flatpak";
    RET=1;
    until [ ${RET} -eq 0 ]; do
        sudo apt install gnome-software-plugin-flatpak flatpak;
        flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
        flatpak --user install flathub org.gnome.Sdk//3.28;
        flatpak --user install flathub org.gnome.Platform//3.28;
        RET=$?;
    done;
else
    echo "Flatpak already installed";
fi

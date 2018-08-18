#!/bin/sh

declare -A pkg;
pkg[/etc/redhat-release]=dnf
pkg[/etc/SuSE-release]=zypp
pkg[/etc/debian_version]=apt-get

echo ""
echo -e "\e[35mThis script will convert all mp3 tracks to oga format via ffmpeg backend.\e[0m"
echo -e "\e[34mYou need to have ffmpeg installed.\e[0m"
echo ""
for f in ${!pkg[@]}
do
    if [[ -f $f ]];then
        echo -e "Install ffmpeg by \e[31m$ sudo ${pkg[$f]} install ffmpeg\e[0m"
    fi
done

echo ""

if [ -x "$(command -v ffmpeg)" ]; then
    echo -e "\e[36mStarting conversion...\e[0m"
    sleep 5;
    for name in *.mp3
        do ffmpeg  -i "$name" -c:a libopus "${name%.mp3}".opus
    done
fi


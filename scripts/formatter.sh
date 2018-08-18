#!/bin/sh

echo "This script will convert every *.c code into (tab -> 2 space indent)"
read -p "Are you sure (y/N)?:" choice
case "$choice" in
    y|Y ) \
            sed -i 's/\t/  /g' $(for i in *.c; do find . -name "$i"; done | cut -d "/" -f2-) \
            && echo "Yay! I hate tabs!" ;;
    n|N ) echo "Noooo! I love tabs!" ;;
    * ) echo -e "\e[36mGo home, You are drunk!\e[0m" ;;
esac

if [ "$(find . -name '*.c' | cut -d '/' -f2)" >/dev/null 2>&1 ];
then
    if [ -x "$(command -v clang-format)" >/dev/null 2>&1 ];
    then
        clang-format -style=google -i $(find . -name "*.c" | cut -d "/" -f 2);
        echo "Done clang formatting!";
    else
        echo -e "\e[35mClang not installed\e[0m"
    fi
else
    echo -e "\e[35mNo C source files\e[0m"
fi

#!/bin/sh

if [ -x "$(command -v git)" > /dev/null ];
then
    git add .;
    git checkout;
    read -p "Enter commit message: " message;
    git commit -m "$message"; git push -uv origin master; 
    read -p "\e[36mWanna see creepy logs? [y/N]:\e[0m " choice
    case $choice in
      y|Y) git log --full-diff;;
      n|N) exit;;
      *) echo "\e[35mYou may drunk now!\e[0m";;
    esac
else
    echo "'git' not installed"
fi

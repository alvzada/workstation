#!/bin/bash

if [ -x "$(command -v git)" > /dev/null ];
then
    git add .;
    git checkout;
    read -p "Enter commit message: " message;
    git commit -m "$message"; git push -uv origin master;
    echo -e "\e[34mWanna see creepy logs?\e[0m"; 
    read -p "[y/N]: " choice;
    case $choice in
      y|Y) git log --full-diff;;
      n|N) echo -e "\e[34mOkey, All good!\e[0m"; exit;;
      *) echo -e "\e[35mYou may drunk now!\e[0m";;
    esac
else
    echo -e "\e35'git' not installed"
fi

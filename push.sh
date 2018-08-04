#!/bin/sh

if [ -x "$(command -v git)" > /dev/null ];
then
    git add .;
    git checkout;
    read -p "Enter commit message: " message;
    git commit -m "$message"; git push -uv origin master; 
    read -p "Wanna see creepy logs? [y/N]: " choice
    case $choice in
      y|Y) git log --full-diff;;
      n|N) exit;;
      *) echo "You may drunk now!";;
    esac
else
    echo "'git' not installed"
fi

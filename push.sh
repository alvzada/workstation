#!/bin/sh

if [ -x "$(command -v git)" > /dev/null ];
then
  read -p "Enter commit message: " message;
  git add .; git commit -m "$message"; git push -uv origin master
else
  echo "'git' not installed"
fi

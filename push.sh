#!/bin/sh

if [ -x "$(command -v git)" > /dev/null ];
then
  git add .;
  git checkout; 
  read -p "Enter commit message: " message;
  git commit -m "$message"; git push -uv origin master; \
    git log --full-diff;
else
  echo "'git' not installed"
fi

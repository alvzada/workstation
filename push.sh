#!/bin/sh

if [ -x "$(command -v git)" > /dev/null ];
then
  git add .; git commit -m "random"; git push -uv origin master
else
  echo "'git' not installed"
fi

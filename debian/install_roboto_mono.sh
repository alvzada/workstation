#!/bin/sh
FONT_HOME=~/.local/share/fonts
echo "installing fonts at $PWD to $FONT_HOME"
mkdir -p "$FONT_HOME/roboto-mono"
cd $FONT_HOME/roboto-mono
(curl -L \
         'https://raw.githubusercontent.com/google/fonts/master/apache/robotomono/RobotoMono-Bold.ttf' -O \
         'https://raw.githubusercontent.com/google/fonts/master/apache/robotomono/RobotoMono-BoldItalic.ttf' -O \
         'https://raw.githubusercontent.com/google/fonts/master/apache/robotomono/RobotoMono-Italic.ttf' -O \
         'https://raw.githubusercontent.com/google/fonts/master/apache/robotomono/RobotoMono-Light.ttf' -O \
         'https://raw.githubusercontent.com/google/fonts/master/apache/robotomono/RobotoMono-LightItalic.ttf' -O \
         'https://raw.githubusercontent.com/google/fonts/master/apache/robotomono/RobotoMono-Medium.ttf' -O \
         'https://raw.githubusercontent.com/google/fonts/master/apache/robotomono/RobotoMono-MediumItalic.ttf' -O \
         'https://raw.githubusercontent.com/google/fonts/master/apache/robotomono/RobotoMono-Regular.ttf' -O \
         'https://raw.githubusercontent.com/google/fonts/master/apache/robotomono/RobotoMono-Thin.ttf' -O \
         'https://raw.githubusercontent.com/google/fonts/master/apache/robotomono/RobotoMono-ThinItalic.ttf' -O 
         \
         fc-cache -f -v)

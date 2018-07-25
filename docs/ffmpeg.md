# FFMPEG media encoder:

![myffmpeg](http://download.komputerswiat.pl/media/2017/344/4842236/ffmpeg.jpg)

Download [here](https://www.ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2)

## Audio

- **Basic audio extraction & conversion:**

``$ ffmpeg -i input_video.mp4 -vn output_audio.opus``

**or for faster conversion**

``$ ffmpeg -i input_video.webm -vn -acodec copy output_audio.opus``

- **With specific encoding**

``$ ffmpeg -i 'video.mp4' -vn -acodec libopus 'extracted.opus'``

**or (Audio - Audio)**

``$ ffmpeg -i input_filename.opus -c:a libvorbis -b:a 320k output_filename.ogg``


# Video

- **Convert video:**

**WEBM**

For ``variable bitrate``:

``ffmpeg -threads 2 -i "input_video.mkv" -s 1920x1080 -r 25 -c:v libvpx-vp9 -crf 30 -b:v 0 -b:a 96k "output_video.webm"``

- **Resize a video**

``$ ffmpeg -i input.mp4 -s 480x320 -c:a copy output.mp4``

# Image

- **Video to Gif**

```bash
$ ffmpeg -y -i gnome-shell.webm -vf palettegen palette.png && \
ffmpeg -y -i gnome-shell.webm -i palette.png -filter_complex paletteuse gnome-shell.gif
```

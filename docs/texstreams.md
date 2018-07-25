# Operating with text streams

**Original output:**

```bash
$ pacman -Ss fonts | grep extra/
```

```perl
extra/adobe-source-code-pro-fonts 2.030ro+1.050it-4
extra/adobe-source-sans-pro-fonts 2.020ro+1.075it-2
extra/adobe-source-serif-pro-fonts 2.000-1
extra/artwiz-fonts 1.3-9
extra/cantarell-fonts 1:0.101-1 [installed]
```

**listing the names of packages only:**

```bash
$ pacman -Ss fonts | awk '{print $1}' | grep extra | cut -b 7-
```

```perl
adobe-source-code-pro-fonts
adobe-source-sans-pro-fonts
adobe-source-serif-pro-fonts
artwiz-fonts
cantarell-fonts

```
**Original output:**

```bash
$ flatpak list
```

```perl
Ref                                                   Options       
com.github.fabiocolacio.marker/x86_64/stable          system,current
org.kde.kdenlive/x86_64/stable                        system,current
org.telegram.desktop/x86_64/stable                    system,current
org.videolan.VLC/x86_64/stable                        system,current
org.freedesktop.Platform.Icontheme.Adwaita/x86_64/1.0 system,runtime
org.freedesktop.Platform.VAAPI.Intel/x86_64/1.6       system,runtime
org.freedesktop.Platform.ffmpeg/x86_64/1.6            system,runtime
org.freedesktop.Platform/x86_64/1.6                   system,runtime
org.gnome.Platform/x86_64/3.28                        system,runtime
org.gnome.Sdk/x86_64/3.28                             system,runtime
org.kde.KStyle.Adwaita/x86_64/5.10                    system,runtime
org.kde.KStyle.Adwaita/x86_64/5.11                    system,runtime
org.kde.KStyle.Adwaita/x86_64/5.9                     system,runtime
org.kde.Platform/x86_64/5.10                          system,runtime
org.kde.Platform/x86_64/5.11                          system,runtime
org.kde.Platform/x86_64/5.9                           system,runtime
```

**Listing package names only**

```bash
$ flatpak list | cut -d "/" -f 1
```
```perl
com.github.fabiocolacio.marker
org.kde.kdenlive
org.telegram.desktop
org.videolan.VLC
org.freedesktop.Platform.Icontheme.Adwaita
org.freedesktop.Platform.VAAPI.Intel
org.freedesktop.Platform.ffmpeg
org.freedesktop.Platform
org.gnome.Platform
org.gnome.Sdk
org.kde.KStyle.Adwaita
org.kde.KStyle.Adwaita
org.kde.KStyle.Adwaita
org.kde.Platform
org.kde.Platform
org.kde.Platform

```

**Append terminal output to a file:**

```bash
$ command |& tee -a filename.log
```
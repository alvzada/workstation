#!/bin/bash

if [[ "$EUID" -ne 0 ]];
then
    echo "Execute as root"
    exit
fi

echo "Setting up desktop";
sleep 2;

# Sources
echo "
  #
  deb http://deb.debian.org/debian/ stable main contrib non-free
  deb-src http://deb.debian.org/debian/ stable main contrib non-free

  deb http://security.debian.org/debian-security stable/updates main contrib non-free
  deb-src http://security.debian.org/debian-security stable/updates main contrib non-free

  # stable-updates, previously known as 'volatile'
  deb http://deb.debian.org/debian/ stable-updates main contrib non-free
  deb-src http://deb.debian.org/debian/ stable-updates main contrib non-free
" > /etc/apt/sources.list;

# Installations
apt update;
apt-get install \
    sudo \
    xfce4 \
    lightdm \
    lightdm-gtk-greeter \
    light-locker \
    xfce4-power-manager \
    xfce4-terminal \
    mousepad \
    orage \
    libreoffice-gtk \
    default-dbus-session-bus \
    xsane \
    catfish \
    evince \
    network-manager-gnome \
    gnome-icon-theme \
    greybird-gtk-theme \
    firefox-esr \
    libreoffice \
    libreoffice-help-en-us \
    mythes-en-us \
    hunspell-en-us \
    hyphen-en-us \
    system-config-printer \
    gnome-orca \
    virt-manager \
    emacs\
    galculator \
    gimp \
    hexchat \
    transmission-gtk \
    thunderbird \
    mpv \
    rhythmbox \
    plymouth \
    plymouth-themes \
    firmware-linux-nonfree \
    firmware-realtek;

sleep 2;
echo "Done!";
sleep 2;
echo "Setting up development tools";
apt-get --no-install-recommends install \
    autoconf \
    automake \
    clang \
    clang-format \
    llvm \
    llvm-runtime \
    splint \
    pkg-config \
    python3-jedi \
    zlib1g-dev \
    valac \
    gdb \
    valgrind-dbg \
    cmake \
    python3 \
    python3-pip \
    python3-wheel \
    python3-setuptools \
    virtualenv \
    vim-python-jedi \
    vim \
    git \
    default-jdk \
    default-jre \
    yasm \
    tmux \
    make \
    patch \
    ccache \
    rsync \
    devscripts \
    equivs \
    deborphan \
    libnotify-bin;

sleep 2;
echo "Done!";
sleep 2;
echo "Configuring system";
sleep 5;

# Progress Bar
echo 'Dpkg::Progress-Fancy "1";'> /etc/apt/apt.conf.d/99progressbar;

# Polkit rules
echo "
  [Permissive]
  Identity=unix-group:sudo
  Action=org.freedesktop.login1*
  ResultActive=yes
  Identity=unix-group:sudo
  Action=org.freedesktop.Flatpak.*
  ResultActive=yes

  Identity=unix-group:sudo
  Action=org.freedesktop.udisks2*
  ResultActive=yes
  Identity=unix-group:sudo
  Action=org.libvirt.*
  ResultActive=yes

  Identity=unix-group:sudo
  Action=org.freedesktop.packagekit.*
  ResultActive=yes

  Identity=unix-group:sudo
  Action=org.freedesktop.systemd1.*
  ResultActive=yes

  Identity=unix-group:sudo
  Action=org.freedesktop.login1.*
  ResultActive=yes
" > /etc/polkit-1/localauthority/50-local.d/disable-passwords.pkla;

# Read kernel buffers for normal users
/sbin/sysctl -w kernel.dmesg_restrict=0;
/sbin/sysctl -w vm.swappiness=10;
read -r -p "What's your username? : " name;
adduser "$name" systemd-journal;

# GRUB Mode
echo "
  GRUB_GFXMODE=1920x1080x32,auto
  GRUB_GFXPAYLOAD="keep"
  GRUB_BACKGROUND='/usr/share/images/desktop-base/default'
" >> /etc/default/grub;

# LightDM Greeter Setup
# background ='/usr/share/images/desktop-base/default'
echo "
  [greeter]
  theme-name = Greybird
  icon-theme-name = Adwaita
  font-name = Sans Condensed 10
  indicators = ~separator;~host;~spacer;~clock;~spacer;~session;~power;~separator
  screensaver-timeout = 0
  default-user-image = /usr/share/pixmaps/debian-logo.png
  position = 15%,center 50%,center

" > /etc/lightdm/lightdm-gtk-greeter.conf;
mkdir -p /etc/lightdm/lightdm.conf.d/;
echo "
    [Seat:*]
    greeter-hide-users=false
" > /etc/lightdm/lightdm.conf.d/custom.conf;

# Plymouth setup
echo "
    # KMS
    intel_agp
    drm
    i915 modeset=1
" >> /etc/initramfs-tools/modules;
plymouth-set-default-theme -R tribar;
update-grub && update-initramfs -uv;
sleep 2;

echo "All set up, please reboot!"

```

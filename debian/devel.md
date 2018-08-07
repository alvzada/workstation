## Development setup

- Debian based systems:

```bash
sudo apt-get --no-install-recommends install \
    autoconf \
    automake \
    clang \
    clang-format \
    llvm \
    llvm-dev \
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
    virtualenv \
    vim-python-jedi \
    vim-nox \
    git \
    default-jdk \
    default-jre \
    yasm
    tmux
    make
    patch
    rsync
```
- Redhat/Fedora systems:

```
sudo dnf --setopt=install_weak_deps=False --best install \
clang \
automake \
autoconf \
llvm \
splint \
pkgconf-pkg-config \
python3-jedi \
vala \
gdb \
valgrind \
cmake \
python3-pip \
python3-virtualenv \
vim-jedi \
vim-omnicppcomplete \
vim-enhanced \
git \
java-openjdk \
yasm
```

## Flatpak Development setup
```bash
#!/bin/sh

if [ ! -x "$(command -v flatpak)" >/dev/null 2>&1 ];
then
    echo "Setting up flatpak";
    if [ -r /etc/os-release ];
    then
        . /etc/os-release
        if [ $ID = debian ] || [ $ID = ubuntu ];
        then
            sudo apt install flatpak flatpak-builder;
        elif
            sudo dnf install flatpak flatpak-builder;
        else
            echo "Not on Deb/RPM based distros";
            echo "Use your package manager to install 'Flatpak'"
            exit;
        fi
    fi

    RET=1;
    until [ ${RET} -eq 0 ]; do
        flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
        echo "";
        read -p "Enter Sdk/runtime version [Ex: 3.28]: " ver;
        flatpak --user install flathub org.gnome.Sdk//$ver;
        flatpak --user install flathub org.gnome.Platform//$ver;
        RET=$?;
    done;
else
    echo "Flatpak already installed";
fi
```

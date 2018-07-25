# Debian Story 

**Don't take this seriously, please!**

I used various systems, some BSD flavors including pretty OSX, FreeBSD, Windows and yeah, the most controversial GNU/Linux distros, but two Linux distributions that took special place at my heart, namely “Debian” and “Arch Linux”. The main reason was challenge of installation and configurability.

However, I slowly discovered that, "Arch" was way too much handhold for me, like a problem appears and then just type “RTFM”, and it’s gone, gentoo was similar except boring datings with emerge and -oO flags, I learnt alot from those systems, but Debian netinstall gave me a new jerk while I was trying to install it on my machine (Really, it was Debian, from where most linux distros derived, specially Ubuntu). It was around the beginning of 2016. The whole story was something like this:

I had nearly around 2GB bandwidth and decided to download a Debian testing CD from their servers with my legendary 2G dialup. I pointed my “wget” to the “URL” and download started.

``wget -c https://link to the horrible ISO”``

I can’t exactly remember the remaining downloading time, but the speed was about 20-40KB/sec or something like that and ISO size was around 300MB (Not really, can’t remember). So, obtained the image, and “dd” the image to USB.

```bash
# mkfs.vat -n “SONY” -I /dev/sdb``
# dd if=firmware-testing-amd64.iso of=/dev/sdb bs=4M && sync
```

OK, done! Reboot. 

Here, presenting the 80s infamous Debian installer, at UEFI boot mode, in front of me... I followed friendly instructions one by one...!

choose language, key-map, hostname, foo, foo.....................network-setup................errrrrrrrrrrr!!

``E:Missing firmware!, blame your awkward X hardware for this. ``

Ops, I could have downloaded the non-free unofficial CD, but we are sons of stall-church and repeatedly advised to follow FSF bible only.

OK, just ignore the message, f*ck the awkward hardware, take my Ethernet cable and continue.

Again, proceed, disk partitions................user-creation, wow, pretty reasonable compared to arch, so easy, so elegant.  So I created a partition table like below:-

```bash
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      	    8:0    0 465.8G  0 disk 
├─sda1   8:1    0   512M  0 part /boot/efi
├─sda2   8:2    0  23.3G  0 part /
├─sda3   8:3    0   9.3G  0 part /var
├─sda4   8:4    0   5.9G  0 part [SWAP]
├─sda5   8:5    0   1.9G  0 part /tmp
└─sda6   8:6    0 424.9G  0 part /home
```
next..................next...................neeeeeeeeeeeeeeext..... 

Ok, now a WIZARD will install Debian. It’s magic. mmmmm.... screw Arch and simplicity.

unpacking foo............fooo........foooo..................
configuring...................................................................
installing.................................................................................................!!!!

ERROR!

```log
E:No kernel modules were found. This probably is due to a mismatch between the kernel used by this version of the installer and the kernel version available in the archive. If you're installing from a mirror, you can work around this problem by choosing to install a different version of Debian.  The install will probably fail to work if you continue without kernel modules."
"Continue to install without loading kernel modules?"

E: No kernel source was defined, without a kernel, your system will be rendered in a non-bootable state! You can install a kernel later but it is not advised to a NOOB like you!
```

WHAT?????? 😲

Now it’s personal! "I am an ex Arch + Gentoo user for years. I spent half of my life cursing *Ubuntu* and *Windows XP* guided by some community hipsters just to look cool. Show some respect!"

Okay installer, proceed without installing any kernel! (I bet, I chose a wrong CD, sorry Torvalds, not your fault)

setting up.......... installing......................still installing.................installing.................. Grub install prompt??? yeah, point to EFI boot partition. Still installing.............................................................

Complete, reboot time!
That meaningless BIOS beep, and the grub. 

Wait.... No OS entry here. 

NO FUCKING OS ENTRY HERE BECAUSE OF NO KERNEL! 

I knew it, hang on. I can fix it.
Inserted a **legendary Gentoo installer** disk, and mounted each partitions by hand.

```bash
# mount /dev/sda2 /mnt
# mount /dev/sda1 /mnt/boot/efi
# mount /dev/sda3 /mnt/var
# mount /dev/sda5 /mnt/tmp
# mount /dev/sda6 /mnt/home/
# mount --bind /dev/ /mnt/dev
# mount --bind /dev/ /mnt/proc
# mount --bind /dev/ /mnt/sys
# mount --bind /run/ mnt/run
# mount --bind /etc/resolve.conf /mnt/etc/resolve.conf
# chroot /mnt
# whoami
root
```

LOL!

It is like, squishing father, mother, brother, sister, BF, GF, Wife, grandma, grandpa, neighbours, all into the same room and make them work. That’s what UNIX provides, flexibility.

Now its showtime... h0x4rs! 

```bash
# sed -i ‘s/testing/unstable/g’ /etc/apt/sources.list && remove extra nonsense testing mirrors
# apt-get update && apt-get dist-upgrade && apt-get -–no-install-recommends gnome-core xserver-xorg pulseaudio alsa-utils gnome-calendar evolution rhythmbox emacs25 numlockx debhelper dh-make packaging-dev debian-keyring devscripts equivs git gdebi-core build-essential meson flatpak flatpak-builder
# apt-get --install-suggests install linux-image-$(uname -r)
# grub-install --efi-directory=/boot/efi --target=x86_64-efi /dev/sda
# update-initramfs -u && update-grub
# exit
# systemctl reboot
```

Landed in a grub rescue mode. 

I guess, it is a trap actually, and debian wants to test my patience!

OK! Take this...

```grub
grub>set root=(hd0,gpt2)
    >linux /boot/efi/vmlinux-(uname -r) root=/dev/sda2
    >load_video
    >loadfont 'terminus 13'
    >insmod gfxterm
    >set locale_dir=$prefix/locale
    >set lang=en_IN
    >insmod gettext
    >boot
```

Mission Accomplished! h0x4r landed in the moon successfully.....!!
Wait... what happened to my Ethernet??

``Ethernet connection unconfirmed!``

WTF??
You know what??.... I am done with this jerk.

```bash
# sed -i 's/auto/true/g' /etc/NetworkManager/NetworkManager.conf
# apt-get --install-no-recommneds firmware-realtek && chown -R $USER . && shutdown -r now
```
Huh.. Finally! Its done. Its really done.
There was no pacstrap and emerge to help me here... No other system to access Wiki. However I did it. I can die in peace now :|
When I remember this day, I really get scared. Really! 

Hopefully I am still running this "Sid" now, as on 30th march 2018 with some strange non-human friendly configurations.
My emacs is crying now, end of story && cya!

# Use fsarhiver to backup

- **Saving filesystems to an archive**

*System is installed on /dev/sdaX and want to backup at /mnt/backup->*

    fsarchiver -j2 -o savefs /mnt/backup/fedora-rootfs.fsa /dev/sdaX

*For several filesystems in a single archive file ->*

    fsarchiver savefs -j2 -o /mnt/backup/fedora-rootfs.fsa /dev/sda1 /dev/sda2 /dev/sdaX -vvv -j2 -A

- **Extract filesystems from an archive**

*Restore a filesystem from an archive when there is only one filesystem in that archive ->*

    fsarchiver restfs /mnt/backup/fedora-rootfs.fsa id=0,dest=/dev/sda1

*For several filesystems restore ->*

    fsarchiver restfs /mnt/backup/fedora-rootfs.fsa id=0,dest=/dev/sda1 id=1,dest=/dev/sda2 ...... like this

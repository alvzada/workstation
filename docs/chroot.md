# Setting up kickass chroot

## My partitions details:

```bash
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 465.8G  0 disk 
├─sda1   8:1    0   512M  0 part /boot/efi
├─sda2   8:2    0  23.3G  0 part /
├─sda3   8:3    0   9.3G  0 part /var
├─sda4   8:4    0   5.9G  0 part [SWAP]
├─sda5   8:5    0   1.9G  0 part /tmp
└─sda6   8:6    0 424.9G  0 part /home
sr0     11:0    1  1024M  0 rom
```
## Disk UUIDs:

```
/dev/sda1: UUID="9AC3-E04D" TYPE="vfat" PARTUUID="c1593e2d-505d-4455-8851-1e113351a8be"
/dev/sda2: UUID="0d0a5cbe-0f84-45aa-880f-0f7d8d096e3d" TYPE="ext4" PARTUUID="1b149d00-89ca-4031-83d0-c944273670fb"
/dev/sda3: UUID="6142b3f8-86b4-436e-8b19-94009a037dcd" TYPE="ext4" PARTUUID="da93c7b0-2ee5-48cd-a2c3-53be2c818628"
/dev/sda4: UUID="7ac7c9de-3562-4d3f-93d1-e4767ac1275f" TYPE="swap" PARTUUID="97e1fc68-cbdf-477b-9fc5-126cdb5b5bd0"
/dev/sda5: UUID="ded31fc4-1f78-460d-99d6-f0895ee47eee" TYPE="ext4" PARTUUID="8804710b-1129-40eb-85c0-f5af84feb4be"
/dev/sda6: UUID="2e167ae6-6cf0-4377-8f9a-e8b84e12a3f5" TYPE="ext4" PARTUUID="ab4be515-4128-4ab4-b51d-8a75f49db50a"
```

**Mount root partition:**

```bash
mount /dev/sda2 /mnt
```

**Mount extra boot/var/tmp/home partitions etc(if any):**

```
mount /dev/sda1 /mnt/boot/efi  /*for UEFI boot*/
mount /dev/sda3 /mnt/var
mount /dev/sda5 /mnt/tmp
mount /dev/sda6 /mnt/home
```

*To run some tasks and services properly in chroot, such as update grub,
 using internet etc, following mounts are helpful*

```bash
mount --bind /dev/ /mnt/dev
mount --bind /proc/ /mnt/proc
mount --bind /sys/ /mnt/sys
mount --bind /run/ /mnt/run
mount --bind /etc/resolv.conf /mnt/etc/resolve.conf  /* for internet access in chroot*/
```

**Now chroot into the installed system:**

```bash
chroot /mnt
```

**Generating new Initramfs**

- in case of Fedora:

```bash
dracut -vf --kver $(uname -r) --hostonly
```
or for more specific results

```bash
dracut -vf --kver 4.17.4-200.fc28.x86_64 --hostonly
```


# Common Problems and Their Solutions | Start-Up |

Data problems are when the machine may or may not boot properly but, in either
case, it is clear that there is data corruption on the system and that the
system needs to be recovered. These situations call for a backup of your
critical data, enabling you to recover the system state from before your
system failed.

### Managing Partition Images 

Sometimes you need to perform a backup from an entire partition or even hard
disk. Linux comes with the `dd` tool which can create an exact copy of your
disk. Combined with `gzip` you save some space.

###### Procedure: Backing up and Restoring Hard Disks 


  1. Start a Shell as user `root`. 

  2. Select your source device. Typically this is something like `/dev/sda` (labeled as _SOURCE_). 

  3. Decide where you want to store your image (labeled as _BACKUP_PATH_). It must be different from your source device. In other words: if you make a backup from `/dev/sda`, your image file must not to be stored under `/dev/sda`. 

  4. Run the commands to create a compressed image file: 
    
        dd if=/dev/_SOURCE_ | gzip > /_BACKUP_PATH_/image.gz

  5. Restore the hard disk with the following commands: 
    
        gzip -dc /_BACKUP_PATH_/image.gz | dd of=/dev/_SOURCE_

If you only need to back up a partition, replace the _SOURCE_ placeholder with
your respective partition. In this case, your image file can lie on the same
hard disk, but on a different partition.

### Using the Rescue System 

There are several reasons a system could fail to come up and run properly. A
corrupted file system following a system crash, corrupted configuration files,
or a corrupted boot loader configuration are the most common ones.

To help you to resolve these situations, openSUSE Leap contains a rescue
system that you can boot. The rescue system is a small Linux system that can
be loaded into a RAM disk and mounted as root file system, allowing you to
access your Linux partitions from the outside. Using the rescue system, you
can recover or modify any important aspect of your system.

  * Manipulate any type of configuration file. 

  * Check the file system for defects and start automatic repair processes. 

  * Access the installed system in a "change root" environment. 

  * Check, modify, and re-install the boot loader configuration. 

  * Recover from a badly installed device driver or unusable kernel. 

  * Resize partitions using the parted command. Find more information about this tool at the GNU Parted Web site <http://www.gnu.org/software/parted/parted.html>. 

The rescue system can be loaded from various sources and locations. The
simplest option is to boot the rescue system from the original installation
medium.

  1. Insert the installation medium into your DVD drive. 

  2. Reboot the system. 

  3. At the boot screen, press F4 and choose . Then choose from the main menu. 

  4. Enter `root` at the `Rescue:` prompt. A password is not required. 

If your hardware setup does not include a DVD drive, you can boot the rescue
system from a network source. The following example applies to a remote boot
scenario--if using another boot medium, such as a DVD, modify the `info` file
accordingly and boot as you would for a normal installation.

  1. Enter the configuration of your PXE boot setup and add the lines `install=_PROTOCOL_://_INSTSOURCE_` and `rescue=1`. If you need to start the repair system, use `repair=1` instead. As with a normal installation, _PROTOCOL_ stands for any of the supported network protocols (NFS, HTTP, FTP, etc.) and _INSTSOURCE_ for the path to your network installation source. 

  2. Boot the system using "Wake on LAN". 

  3. Enter `root` at the `Rescue:` prompt. A password is not required. 

Once you have entered the rescue system, you can use the virtual consoles that
can be reached with Alt-F1 to Alt-F6.

A shell and many other useful utilities, such as the mount program, are
available in the `/bin` directory. The `/sbin` directory contains important
file and network utilities for reviewing and repairing the file system. This
directory also contains the most important binaries for system maintenance,
such as `fdisk`, `mkfs`, `mkswap`, `mount`, and `shutdown`, `ip` and `ss` for
maintaining the network. The directory `/usr/bin` contains the vi editor,
find, less, and SSH.

To see the system messages, either use the command `dmesg` or view the system
log with `journalctl`.

#### Checking and Manipulating Configuration Files

As an example for a configuration that might be fixed using the rescue system,
imagine you have a broken configuration file that prevents the system from
booting properly. You can fix this using the rescue system.

To manipulate a configuration file, proceed as follows:

  1. Start the rescue system using one of the methods described above. 

  2. To mount a root file system located under `/dev/sda6` to the rescue system, use the following command: 

```bash
sudo mount /dev/sda6 /mnt
```

All directories of the system are now located under `/mnt`

  3. Change the directory to the mounted root file system: 

  4. Open the problematic configuration file in the vi editor. Adjust and save the configuration. 

  5. Unmount the root file system from the rescue system: 

  6. Reboot the machine. 

#### Repairing and Checking File Systems 

Generally, file systems cannot be repaired on a running system. If you
encounter serious problems, you may not even be able to mount your root file
system and the system boot may end with a "kernel panic". In this case, the
only way is to repair the system from the outside. The system contains the
utilities to check and repair the `btrfs`, `ext2`, `ext3`, `ext4`, `reiserfs`,
`xfs`, `dosfs`, and `vfat` file systems. Look for the command `fsck.`
_FILESYSTEM_, for example, if you need a file system check for `btrfs`, use
`fsck.btrfs`.

#### Accessing the Installed System

If you need to access the installed system from the rescue system, you need to
do this in a _change root_ environment. For example, to modify the boot loader
configuration, or to execute a hardware configuration utility.

To set up a change root environment based on the installed system, proceed as
follows:

  1. Import
all existing volume groups in order to be able to find and mount the
device(s):

Run `lsblk` to check which node corresponds to the root partition. It is
`/dev/sda2` in our example:

    
        lsblk
    NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
    sda 8:0 0 149,1G 0 disk
    ├─sda1 8:1 0 2G 0 part [SWAP]
    ├─sda2 8:2 0 20G 0 part /
    └─sda3 8:3 0 127G 0 part └─cr_home 254:0 0 127G 0 crypt /home

  2. Mount the root partition from the installed system: 

  3. Mount `/proc`, `/dev`, and `/sys` partitions: 

```bash
mount -t proc none /mnt/proc
mount --rbind /dev /mnt/dev
mount --rbind /sys /mnt/sys
```

  4. Now you can "change root" into the new environment, keeping the `bash` shell: 

  5. Finally, mount the remaining partitions from the installed system: 

  6. Now you have access to the installed system. Before rebooting the system, unmount the partitions with `umount` `-a` and leave the "change root" environment with `exit`. 

Although you have full access to the files and applications of the installed
system, there are some limitations. The kernel that is running is the one that
was booted with the rescue system, not with the change root environment. It
only supports essential hardware and it is not possible to add kernel modules
from the installed system unless the kernel versions are identical. Always
check the version of the currently running (rescue) kernel with `uname -r` and
then find out if a matching subdirectory exists in the `/lib/modules`
directory in the change root environment. If yes, you can use the installed
modules, otherwise you need to supply their correct versions on other media,
such as a flash disk. Most often the rescue kernel version differs from the
installed one -- then you cannot simply access a sound card, for example. It
is also not possible to start a graphical user interface.

Also note that you leave the "change root" environment when you switch the
console with Alt-F1 to Alt-F6.

#### Modifying and Re-installing the Boot Loader 

Sometimes a system cannot boot because the boot loader configuration is
corrupted. The start-up routines cannot, for example, translate physical
drives to the actual locations in the Linux file system without a working boot
loader.

To check the boot loader configuration and re-install the boot loader, proceed
as follows:

  1. Perform the necessary steps to access the installed system (chroot setup)

  2. Check that the GRUB 2 boot loader is installed on the system. If not, install the package `grub2`.

  3. Check whether the following files are correctly configured.

- `/etc/default/grub`

- `/boot/grub2/device.map` (optional file, only present if created manually) 

- `/boot/grub2/grub.cfg` (this file is generated, do not edit) 

- `/etc/sysconfig/bootloader`

  4. Re-install the boot loader using the following command sequence: 
    
        grub2-mkconfig -o /boot/grub2/grub.cfg

  5. Unmount the partitions, log out from the "change root" environment, and reboot the system: 

#### Fixing Kernel Installation 

A kernel update may introduce a new bug which can impact the operation of your
system. For example a driver for a piece of hardware in your system may be
faulty, which prevents you from accessing and using it. In this case, revert
to the last working kernel (if available on the system) or install the
original kernel from the installation media.


To prevent failures to boot after a faulty kernel update, use the kernel
multiversion feature and tell `libzypp` which kernels you want to keep after
the update.

For example to always keep the last two kernels and the currently running one,
add

    
    multiversion.kernels = latest,latest-1,running

to the `/etc/zypp/zypp.conf` file.

A similar case is when you need to re-install or update a broken driver for a
device not supported by openSUSE Leap. For example when a hardware vendor uses
a specific device, such as a hardware RAID controller, which needs a binary
driver to be recognized by the operating system. The vendor typically releases
a Driver Update Disk (DUD) with the fixed or updated version of the required
driver.

In both cases you need to access the installed system in the rescue mode and
fix the kernel related problem, otherwise the system may fail to boot
correctly:

  1. Boot from the openSUSE Leap installation media. 

  2. If you are recovering after a faulty kernel update, skip this step. If you need to use a driver update disk (DUD), press F6 to load the driver update after the boot menu appears, and choose the path or URL to the driver update and confirm with . 

  3. Choose from the boot menu and press Enter. If you chose to use DUD, you will be asked to specify where the driver update is stored. 

  4. Enter `root` at the `Rescue:` prompt. A password is not required. 

  5. Manually mount the target system and "change root" into the new environment.

  6. If using DUD, install/re-install/update the faulty device driver package. Always make sure the installed kernel version exactly matches the version of the driver you are installing. 

If fixing faulty kernel update installation, you can install the original
kernel from the installation media with the following procedure.

  7. Update configuration files and reinitialize the boot loader if needed.

  8. Remove any bootable media from the system drive and reboot. 


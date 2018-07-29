## Backup

The following is an exemplary command of how to archive your system:

```bash
tar -cvpzf backup.tar.gz --exclude=/backup.tar.gz --one-file-system / 
```
or a single folder:

```bash
tar -cvpzf backup.tar.gz <folder-to-back-up>
```

Explaination:

```doc
c - create a new backup archive.

v - verbose mode, tar will print what it's doing to the screen.

p - preserves the permissions of the files put in the archive for restoration later.

z - compress the backup file with 'gzip' to make it smaller.

f <filename> - specifies where to store the backup, backup.tar.gz is the filename used in this example. 
It will be stored in the current working directory, the one you set when you used the cd command.

--exclude=/example/path - 
The options following this model instruct tar what directories NOT to backup. 
We don't want to backup everything since some directories aren't very useful to include. T
he first exclusion rule directs tar not to back itself up, this is important to avoid errors during the operation. 

--one-file-system - 
Do not include files on a different filesystem. If you want other filesystems, such as a /home partition, 
or external media mounted in /media backed up, you either need to back them up separately, or omit this flag. 
If you do omit this flag, you will need to add several more --exclude= arguments to avoid filesystems you do
not want. These would be /proc, /sys, /mnt, /media, /run and /dev directories in root. /proc and /sys are virtual
filesystems that provide windows into variables of the running kernel, so you do not want to try and backup or restore them.
/dev is a tmpfs whose contents are created and deleted dynamically by udev, so you also do not want to backup
or restore it. Likewise, /run is a tmpfs that holds variables about the running system 
that do not need backed up.
```
## Restore:

```bash
sudo tar -xvpzf /path/to/backup.tar.gz -C /media/whatever --numeric-owner
```
A brief explanation: 

```doc
x - 
Tells tar to extract the file designated by the f option immediately after. In this case, 
the archive is /home/test/backup.tar.gz.

-C <directory> - 
This option tells tar to change to a specific directory before extracting. In this example, 
we are restoring to the root (/) directory. 

--numeric-owner - 
This option tells tar to restore the numeric owners of the files in the archive, rather than
matching to any user names in the environment you are restoring from. This is due to that the 
user id:s in the system you want to restore don't necessarily match the system you use to restore (eg a live CD). 

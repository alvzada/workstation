# Some privileges to casual user

**Read ``journalctl`` as normal user**

Add yourself to group "systemd-journald"

```bash
$ sudo adduser $USER systemd-journal
$ groups
fre4k cdrom floppy sudo audio dip video plugdev systemd-journal netdev
```

then uncomment/add the following line in "/etc/systemd/journald.conf"

``sudo -e /etc/systemd/journald.conf``

```bash
Storage=auto
```
**Read ``dmesg`` as normal user**

Uncomment/add the following line in "/etc/sysctl.conf"

```bash
kernel.dmesg_restrict=0
```

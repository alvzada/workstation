- As on Fri, 5 May 2017, from version 0.128, initramfs uses swap for resume/suspend. To control its behavior, modify resume variable in:
```bash
# echo "RESUME=auto" >> "/etc/initramfs-tools/initramfs.conf"
```

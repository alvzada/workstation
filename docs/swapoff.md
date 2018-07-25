- **Turn-off swap permanently:**

```bash
user@localhost: ~ $
sudo swapoff -a && sudo systemctl mask dev-sda4.swap
```
then comment out the swap partition line from `/etc/fstab`

- **Set swappiness low:**

```bash
root@localhost: ~ # 
echo "vm.swappiness=10" > /etc/sysctl.d/swappiness.conf
```


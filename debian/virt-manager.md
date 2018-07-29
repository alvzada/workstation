# Virtualization:

- **Installation**
```bash
$ sudo apt-get --no-install-recommends install \
  qemu-kvm \
  libvirt-clients \
  libvirt-daemon-system \
  virt-manager \
  gir1.2-spice-client-gtk-3.0 \
  qemu-utils
```
- **Proper permissions**
```bash
$ sudo adduser <youruser> libvirt
$ sudo adduser <youruser> libvirt-qemu
```
- **List domains**
```bash
$ sudo virsh list --all
```
- **Between VM host, guests and the world**
```bash
$ sudoedit vi /etc/network/interfaces

auto lo
iface lo inet loopback

# The primary network interface
auto eth0

#make sure we don't get addresses on our raw device
iface eth0 inet manual
iface eth0 inet6 manual

#set up bridge and give it a static ip
auto br0
iface br0 inet static
        address 192.168.1.2
        netmask 255.255.255.0
        network 192.168.1.0
        broadcast 192.168.1.255
        gateway 192.168.1.1
        bridge_ports eth0
        bridge_stp off
        bridge_fd 0
        bridge_maxwait 0
        dns-nameservers 8.8.8.8

#allow autoconf for ipv6
iface br0 inet6 auto
        accept_ra 1

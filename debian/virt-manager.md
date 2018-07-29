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
*The virbr0, or "Virtual Bridge 0" interface is used for NAT (Network Address Translation). It is provided by the libvirt library, and virtual environments sometimes use it to connect to the outside network. to remove it if nothing else depends on it, use the following command:*
```bash
$ sudo ip link set dev virbr0 down && sudo brctl delbr virbr0
```
for more on, libvirt, visit: https://wiki.libvirt.org/page/Networking

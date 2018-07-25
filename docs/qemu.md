## Create VM from qcow2 image

```bash
sudo virt-install --name Ubuntu --memory 1024 --network=default --disk ubuntu18.04.qcow2 --import
```

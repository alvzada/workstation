## Copy files (cp -a emulation)

```bash
$ rsync --recursive --progress --human-readable --modify-window=1 <source> <destination>
```

## SSH transfer

```bash
rsync -av -r -e ssh <source> fr0xk@192.168.122.53:/home/fr0xk/
```

## Move files (mv -r emulation)

```bash
$ rsync --recursive --progress --human-readable --modify-window=1 --remove-source-files <source> <destination>
```

# DNF advanced commands

- **List dependencies**

```bash
dnf repoquery --requires --resolve mpv
```

- **List all installed packages**

``bash
sudo dnf list installed | awk '{print $1}' | cut -d "." -f 1
```

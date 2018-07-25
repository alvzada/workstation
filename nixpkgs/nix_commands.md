# Getting Started With Nix Package Manager

Nix has many commands. The main command for the package management is nix-env. This command is used to list, install, update, rollback, remove, query packages

- **Installing Nix package manager**

``$ curl https://nixos.org/nix/install | sh``

- **Updating Nix channels**

``$ nix-channel --update``

- **Add repo**

``$ nix-channel --add https://nixos.org/channels/nixpkgs-unstable``

- **Remove repo**

``$ nix-channel --remove nixpkgs``

- **Search/query available packages**

``$ nix-env -qa``

or for particular packages

``$ nix-env -qa chromium``

- **list all installed packages**

``$ nix-env -q``

- **Installing packages**

``$ nix-env --install gcc``

check if gcc is installed or not by:-

``$ gcc -v``

- **Test packages without installing**

``nix-shell -p gcc``

- **Upgrading packages**

``$ nix-env --upgrade vim``

for all packages at once -

``$ nix-env -u``

- **Rollback packages**

``$ nix-env --rollback``

- **Uninstalling packages**

``nix-env -e gcc vim foo1``

- **Removing unused packages**

``$ nix-collect-garbage -d``

- **run and use a package**

``$ nix run nixpkgs.gcc``

  or simply type:

``$ gcc main.c -o main``

**Note: package conflict priority:**

``nix-env --set-flag priority 15 $PKGNAME``

## Create desktop icons for GUI apps like below:

```bash
$ vi ~/.local/share/applications/Emacs.desktop
```

```desktop
[Desktop Entry]                                                                               
Version=1.0                                                                                   
Type=Application                                                                              
Name=Emacs                                                                                    
GenericName=Text Editor                                                                       
Comment=GNU Emacs is an extensible, customizable text editor - and more                       
Icon=emacs25                                                                                  
TryExec=/home/fr0xk/.nix-profile/bin/emacs                                                    
Exec=/home/fr0xk/.nix-profile/bin/emacs %F                                                    
NoDisplay=false                                                                               
Categories=Development;TextEditor;Utility;                                                    
Keywords=Text;Editor;                                                                         
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text$
StartupWMClass=Emacs                                                                          
StartupNotify=false                                                                           
Terminal=false                                                                                
Name[en_IN]=Emacs
```

# pdot

Download and configure with
```bash
git clone git@github.com:thepith/pdot.git
cd pdot
./configure.sh
```
Install with
```bash
./install.sh install
```
update a current version of pdot with
```bash
./install.sh update
```
To completly uninstall pdot and restore any previous files (no guarantee):
```bash
./install.sh uninstall
```

## Usefull commands
### Cygwin
Install apy-cyg with cygwin (install `lynx` using the cygwin installer):
```bash
lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
install apt-cyg /bin
rm apt-cyg
```
Install Needed programs with cygwin using apt-cyg
```bash
apt-cyg install git vim git wget tmux python-setuptools curl make bc
easy_install-3.6 pip
```

Link to mintty-terminal:
```
C:\cygwin\bin\mintty.exe -e /bin/bash --login
```
Set the terminal type to `xterm-256color` (right click on the terminal > Options... > Terminal > Type)

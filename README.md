# pdot

Download and configure with
```bash
git clone git@github.com:thepith/pdot.git
cd pdot
./configure.sh
```
Backup your old dotfiles with
```bash
make backup
```

Install/Update with
```bash
make
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
apt-cyg install git vim git wget tmux python-setuptools curl make
easy_install-3.6 pip
```
Link to mintty-terminal:
```
C:\cygwin\bin\mintty.exe -e /bin/bash --login
```
Set the terminal type to `xterm-256color` (right click on the terminal > Options... > Terminal > Type)

Use (MikTex)[https://miktex.org/howto/install-miktex] instead of (texlive)[https://www.tug.org/texlive/]. This will spare you some nerves. How to add a local `TEXMF` location is described in the (manual)[http://docs.miktex.org/manual/localadditions.html] (please avoid spaces in the `TEXMF` path).

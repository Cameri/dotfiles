# dotfiles
Dotfiles

## Requirements
* git
* wget
* zsh
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* [antigen](https://github.com/zsh-users/antigen)
* fzf
* xorg-server
* xorg-setxkbmap
* xorg-xclipboard
* xorg-xev
* xsel
* nvidia
* awesome
* pacaur
* ttf-ubuntu-font-family
* tamsyn-font (provides terminal font)
* tamzen-font-git (provides TamzenForPowerline font, required by spaceship prompt)
* sakura
* openssh (provides ssh, sshd, ssh-add, ssh-agent, ssh-keygen, scp)
* zip
* unzip
* xorg-xrandr (provides xrandr)
* ranger (file manager)
* [colorpicker](https://github.com/Jack12816/colorpicker)
* dmenu
* scrot (for screenshots)
* nitrogen (for managing the desktop background)
* noto-fonts-emoji (provides emoji as SVG)
* gnome-screensaver
* gdm
* pasystray

## Extra deps
* paprefs (PulseAudio preferences)
* pulseaudio-gconf
* pulseaudio-alsa
* pavucontrol
* mopidy
* mopidy-iris
* mopidy-local-sqlite
* mopidy-notifier-git
* nvidia-settings
* xclip
* htop
* tmux
* apcupsd (power management for APC's UPS units)
* feh (image viewer)
* imagemagick (extra image support for feh)
* ttf-iosevka-ss09 (programming font for VS Code)

## Apps
* tixati
* telegram-desktop-bin
* peek (screen recording)
* spotify

## Installation and configuration
### Networking
* Add a file named `20-wired.network` to `/etc/systemd/network` with:
```
[Match]
Name=en*

[Network]
DHCP=yes
```
* Follow [this guide](https://wiki.archlinux.org/index.php/Systemd-networkd#Wireless_adapter) for wireless adapters.

### Pacaur

* `$ gpg --list-keys`
* `echo keyring /etc/pacman.d/gnupg/pubring.gpg > ~/.gnupg/gpg.conf`
* Install cower from AUR (pacaur dependency)
* Install pacaur from AUR

### GPG Agent
The GPG Agent is required for Telegram (citation needed).

* `$ md ~/.config/systemd/user/gpg-agent.service.d`
* `$ ln -s systemd/user/gpg-agent.service.d/custom.conf ~/.config/systemd/user/gpg-agent.service.d/`
* `$ systemctl --user enable gpg-agent.service`
* `$ systemctl --user start gpg-agent.service`

### PulseAudio
* `systemctl --user enable pulseaudio.service`
* `systemctl --user start pulseaudio.service`

### SSH Agent
* `systemctl --user enable ssh-agent.service`
* `systemctl --user start ssh-agent.service`
* Generate a new ssh key pair with `$ ssh-keygen`
* Add to SSH agent with `$ ssh-add ~/.ssh/id_rsa`

### SSH Server
Enable this to allow incoming remote connections.
* Edit `/etc/ssh/sshd_contig` and secure as needed.
* `# systemctl enable sshd.service`
* `# systemctl start sshd.service`

### APCUPSD
* Edit scripts in `/etc/apcupsd` as needed
* `# systemctl enable apcupsd`
* `# systemctl start apcupsd`

### dmenu
* TODO

### Keyboard (US Altgr-Intl)
To enable it temporarily:
* `$ localectl set-x11-keymap us "" altgr-intl`
To make it permanent, add it to your session init script.

### Ranger
Create trash folder for `DD` hotkey and `:empty` console command
* `mkdir ~/.Trash`
Link ranger config files
* `ln -s $DOTFILES/ranger $HOME/.config/`

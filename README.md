# dotfiles
Dotfiles

## Requirements
* git
* wget
* zsh
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* [antigen](https://github.com/zsh-users/antigen)
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
* sakura
* openssh (provides ssh, ssh-add, ssh-agent, ssh-keygen, scp)
* zip
* unzip
* xorg-xrandr (provides xrandr)
* ranger (file manager)
* [colorpicker](https://github.com/Jack12816/colorpicker)
* dmenu
* scrot (for screenshots)
* acpilight (for brightness control)
* nitrogen (for managing the desktop background)
* noto-fonts-emoji (provides emoji as SVG)
* zenity (for dialogs)

## Extra
* playerctl (control music players through D-Bus)
* paprefs (PulseAudio preferences)
* pulseaudio-gconf
* pulseaudio-alsa
* pavucontrol
* telegram-desktop-bin
* peek (screen recording)
* spotify
* mopidy
* mopidy-iris
* mopidy-local-sqlite
* mopidy-notifier-git
* nvidia-settings
* xclip
* tixati
* htop
* tmux
* apcupsd (power management for APC's UPS units)
* netcat (provides `nc`)

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

### APCUPSD
* `# systemctl enable apcupsd`
* `# systemctl start apcupsd`
* Edit scripts in `/etc/apcupsd` as needed

### dmenu
* `cd .config/awesome && ln -s $DOT_FILES/awesome/dmenu`

# Configuration

## Networking
* Add a file named `20-wired.network` to `/etc/systemd/network` with:
```
[Match]
Name=en*

[Network]
DHCP=yes
```
* Follow [this guide](https://wiki.archlinux.org/index.php/Systemd-networkd#Wireless_adapter) for wireless adapters.
* `$ systemctl enable systemd-networkd`
* `$ systemctl enable systemd-resolvd`

## Pacaur

* `$ gpg --list-keys`

* `$ echo keyring /etc/pacman.d/gnupg/pubring.gpg > ~/.gnupg/gpg.conf`
* Install cower from AUR (pacaur dependency)
* Install pacaur from AUR

## GPG Agent
The GPG Agent is required for Telegram (citation needed).

* `$ md ~/.config/systemd/user/gpg-agent.service.d`
* `$ ln -s systemd/user/gpg-agent.service.d/custom.conf ~/.config/systemd/user/gpg-agent.service.d/`
* `$ systemctl --user enable gpg-agent.service`
* `$ systemctl --user start gpg-agent.service`

## Awesome WM
* `$ rm -rf ~/.config/awesome`
* `$ ln -s $DOTFILES/awesome ~/.config/awesome`
* `$ cd ~/.config/awesome`
* `$ git submodule init`
* `$ git submodule update --recursive`
Disable fs widget in Steamburn (Ubuntu only):
* `$ cp ~/.config/awesome/disable_fs_widget.patch ~/.config/awesome/themes/`
* `$ cd ~/.config/awesome/themes`
* `$ git apply disable_fs_widget.patch`
Note: Ubuntu 16.04.4 LTS does not support Lain's fs widget. This widget must be disabled in each theme used.

## Tamsyn & Other bitmap fonts (Ubuntu only)
* `# rm /etc/fonts/conf.d/70-no-bitmaps.conf`
* `# ln /etc/fonts/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d/`

## PulseAudio
* Install pulseaudio-alsa, paprefs, pasystray, 
* `$ systemctl --user enable pulseaudio.service`
* `$ systemctl --user start pulseaudio.service`

## SSH Agent
* `$ systemctl --user enable ssh-agent.service`
* `$ systemctl --user start ssh-agent.service`
* Generate a new ssh key pair with `$ ssh-keygen`
* Add to SSH agent with `$ ssh-add ~/.ssh/id_rsa`

## SSH Server
Enable this to allow incoming remote connections.
* Edit `/etc/ssh/sshd_config` and secure as needed.
* `# systemctl enable sshd.service`
* `# systemctl start sshd.service`

## APCUPSD
* Edit scripts in `/etc/apcupsd` as needed
* `# systemctl enable apcupsd`
* `# systemctl start apcupsd`

## dmenu
* TODO

## Keyboard (US Altgr-Intl)
To enable it temporarily:
* `$ localectl set-x11-keymap us "" altgr-intl`
To make it permanent, add it to your session init script.

## Ranger
Create trash folder for `DD` hotkey and `:empty` console command
* `$ mkdir ~/.Trash`
Link ranger config files
* `$ ln -s $DOTFILES/ranger $HOME/.config/`

## VS Code
Fix max user watches warning for big projects:
* `$ echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p`

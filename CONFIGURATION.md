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

## GPG (Mac OS X)
* `$ brew install gpg`

Add Keybase GPG key to local GPG agent:
* `$ export GPG_TTY=$(tty)`
* `$ keybase pgp export -s | gpg --allow-secret-key-import --import`
* `$ gpg --list-secret-keys --keyid-format LONG`

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

## Git
* Make `micro` the default editor for Git:
* `$ git config --global core.editor "micro"`
* `$ git config --global push.default current`
* Improve git log:
* `$ git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"`
* `$ git config --global commit.gpgsign true`
* `$ git config --global user.signingkey 8949679922214342`

## SSH Server
Enable this to allow incoming remote connections.
* Edit `/etc/ssh/sshd_config` and secure as needed.
* `# systemctl enable sshd.service`
* `# systemctl start sshd.service`

## APCUPSD
* Edit scripts in `/etc/apcupsd` as needed
* `# systemctl enable apcupsd`
* `# systemctl start apcupsd`

## Keyboard (US Altgr-Intl)
To enable it temporarily:
* `$ localectl set-x11-keymap us "" altgr-intl`
To make it permanent, add it to your session init script.

## Ranger
Create trash folder for `DD` hotkey and `:empty` console command
* `$ mkdir ~/.Trash`
Link ranger config files
* `$ ln -s $DOTFILES/ranger $HOME/.config/`

## VS Code (Linux)
Fix max user watches warning for big projects:
* `$ echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p`

## VS Code (Mac OS X)
```
$ echo kern.maxfiles=65536 | sudo tee -a /etc/sysctl.conf
$ echo kern.maxfilesperproc=65536 | sudo tee -a /etc/sysctl.conf
# sysctl -w kern.maxfiles=65536
# sysctl -w kern.maxfilesperproc=65536
```

Fix thin fonts after upgrading to Mac OS Mojave:
* `$ defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO`

## Alsa
To fix volume being too low, set sound card master volume using `alsamixer` and then store it with:
* `# alsactl store`

## Redis (Mac OS X)
After Redis is installed with Brew it may not start because there is a folder missing.

To see the error:
* `$ tail -f /usr/local/var/log/redis.log`

To fix the error:
* `# mkdir -p /usr/local/var/db/redis`
* `# chown -R cameri /usr/local/var/db`

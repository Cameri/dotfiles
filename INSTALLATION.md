# Linux Installation

## Utilities

### Wine
* [Enable](https://wiki.archlinux.org/index.php/Multilib) the multilib repository
* Update repository cache:
  * `# pacman -Syy`
* Install wine, winetricks wine_gecko, wine-mono
  * `# pacman -S wine winetricks wine_gecko wine-mono`
* Install extra dependencies:
  * `# pacman -S lib32-nvidia-utils lib32-pulse lib32-alsa lib32-alsa-plugins lib32-openal lib-mpg123 lib32-giflib lib32-libpng lib32-gnutls`
* Create wine prefixes:
  * 32-bit: `$ env WINEARCH=win32 WINEPREFIX=~/.win32 wineboot -u`
  * 64-bit: `$ env WINEPREFIX=~/.win64 wineboot -u`
* Run winetricks for each prefix and install:
  * corefonts
  * d3dx9
  * _TBD_

Note: ~/.win32 and ~/.win64 will be your equivalent `C:\` drives in Win


## Applications
### Discord
* Add GPG public keys
  * `$ gpg --recv-keys --keyserver hkp://pgp.mit.edu 0FC3042E345AD05D`
* Install `discord` from AUR
  * `$ pacaur -S discord`

## G13 Advanced Gameboard
* `$ git clone git@github.com:JoelRSimpson/g13.git`
* `$ cd g13 && make`
* `# cp ../g13 /opt -r`

# Mac OS X Installation

## Utilities
* iTerm2
* Docker desktop
  * Download and install Docker desktop from Docker hub
* zsh
  * `brew install zsh` 
* oh-my-zsh
  * Run script from oh-my-zsh repository
  * Change user shell to zsh
  * `$ chsh $(whoami) $(which zsh)`
* micro
  * `$ brew install micro`
* exa
  * `$ brew install exa`
* htop
  * `$ brew install htop`
* fzf
  * `$ brew install fzf`
  * Follow instructions if needed
* node version manager (nvm)
  * `$ brew install nvm`
* AWS command line tools
  * `$ brew install awscli`
* Docker Compose
  * `$ brew install docker-compose`
* Adobe Acrobat Reader
  * Download and install from Adobe's website
* GPG Tools
* BitWarden
* [Displayplacer](https://github.com/jakehilborn/displayplacer)

## Productivity applications
* PyCharm
* DBeaver
* Visual Studio Code - Insiders
* GitKraken
* Postman
* Portainer

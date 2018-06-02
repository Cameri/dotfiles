# Installation instructions

## Services
TODO

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

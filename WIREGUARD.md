# Configuring Wireguard

## Raspberry Pi

### Configure hostname (Optional)
```sh
hostname="wg.local"
sudo tee -a /etc/hosts <<EOF > /dev/null
127.0.0.1 $hostname
::1 $hostname
EOF
sudo hostnamectl set-hostname $hostname
```

### Configure DNS (Optional)
```sh
dns="8.8.8.8"
sudo perl -pi -e "s/^#?name_servers ?=.*$/name_servers=$dns/g" /etc/resolvconf.conf
```

### Install Wireguard on Raspberry Pi 3 or newer:
[Source](https://github.com/adrianmihalko/raspberrypiwireguard/blob/master/README.md)
```sh
# Enable promiscuous mode
sudo perl -pi -e 's/#?net.ipv4.ip_forward ?= ?(0|1)/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf 
sudo perl -pi -e 's/#?net.ipv6.conf.all.forwarding ?= ?(0|1)/net.ipv6.conf.all.forwarding = 1/g' /etc/sysctl.conf 

# Add unstable sources
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC
echo "deb http://deb.debian.org/debian/ unstable main" | sudo tee --append /etc/apt/sources.list.d/unstable.list
printf 'Package: *\nPin: release a=unstable\nPin-Priority: 150\n' | sudo tee --append /etc/apt/preferences.d/limit-unstable

# Update Raspberry Pi
sudo apt-get update
sudo apt-get upgrade

# Install dependencies
sudo apt-get install raspberrypi-kernel-headers
sudo apt-get install dirmngr 

# Install wireguard (Raspberry Pi 3B+ or newer)
sudo apt-get install wireguard

# Reboot
sudo reboot
```

### Install Wireguard on Raspberry Pi 1, 2, Zero and Zero W
[Source](https://github.com/adrianmihalko/raspberrypiwireguard/wiki/Install-WireGuard-on-Raspberry-Pi-1,-2-(not-v1.2),-Zero,-Zero-W)
```sh
sudo apt-get install raspberrypi-kernel-headers libmnl-dev libelf-dev build-essential git
git clone https://git.zx2c4.com/WireGuard
cd WireGuard/src
make
sudo make install
# and later to update Wireguard
# cd WireGuard/src && git pull && make && sudo make install
```

### Upgrade Wireguard on Raspberry Pi 1, 2, Zero and Zero W

### Generate private and public keys
```sh
mkdir ~/wgkeys && cd ~/wgkeys
wg genkey > server_private.key
wg pubkey > server_public.key < server_private.key
```
### Create configuration file
```sh
cd ~/wgkeys
server_address="192.168.99.1/24"
port="51820"
sudo tee /etc/wireguard/wg0.conf <<EOF > /dev/null
[Interface]
Address = $server_address
ListenPort = $port

PrivateKey = $(cat server_private.key)
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

EOF
```

### Verify configuration
```sh
sudo wg-quick up wg0
sudo wg
sudo wg-quick down wg0
```

### Enable wireguard service
```sh
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0
```

### Add a peer
Warning: Without \[Peer\] sections, Wireguard accepts anonymous connections.
```sh
peer_name="Fett, Boba"
peer_address="192.168.99.100/24"
peer_public_key="<peer public key here>"
# or alternatively
# peer_public_key=$(cat peer_public.key)

# Permanently add peer to configuration
sudo tee -a /etc/wireguard/wg0.conf <<EOF > /dev/null
[Peer]
# Name: ${peer_name}
PublicKey = ${peer_public_key}
AllowedIPs = ${peer_address}

EOF
# Add peer immediately
wg set wg0 peer ${peer_public_key} allowed-ips ${peer_address}
```

# Reload the configuration
```sh
sudo wg addconf wg0 <(wg-quick strip wg0)
```
Note: This command did not work when tested.

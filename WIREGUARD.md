# Configuring Wireguard

## Raspberry Pi

### Configure hostname (Optional)
```sh
sudo tee -a /etc/hosts <<EOF > /dev/null
127.0.0.1 wg wg.local
::1 wg wg.local
EOF
hostname="wg.local"
sudo hostnamectl set-hostname $hostname
```

### Configure DNS (Optional)
```sh
dns="8.8.8.8"
sudo perl -pi -e "s/^#?name_servers ?=.*$/name_servers=$dns/g" /etc/resolvconf.conf
```

### Install Wireguard:
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

# Install wireguard
sudo apt-get install wireguard

# Reboot
sudo reboot
```

### Generate private and public keys
```sh
mkdir ~/wgkeys && cd ~/wgkeys
wg genkey > server_private.key
wg pubkey > server_public.key < server_private.key
```
### Create configuration file
```sh
cd ~/wgkeys
address="192.168.99.1/24"
port="51820"
sudo mkdir -p /etc/wireguard
sudo tee /etc/wireguard/wg0.conf <<EOF > /dev/null
[Interface]
Address = $address
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

### Add peer
```sh
extra_addresses=""
peer_name="Fett, Boba"
peer_address="192.168.99.100/24"
peer_public_key="<peer public key here>"
# or alternatively
# peer_public_key=$(cat peer_public.key)
```

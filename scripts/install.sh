#!/data/data/com.termux/files/usr/bin/sh
termux-wake-lock
termux-setup-storage
pkg update
pkg upgrade

# ssh
pkg install openssh
echo "Set SSH password:"
passwd #setting the password
sshd

pkg install termux-api tsu python rust binutils libjpeg-turbo build-essential cmake libopenblas pkg-config screen rsync
pkg install python-cryptography python-numpy

rsync -a ./hass.sh ~/scripts/
rsync -a ./update_ip.py ~/scripts/
rsync -a ../termux/boot/ ~/.termux/boot/

# VPN
TAILSCALE_VER="1.76.1"
# curl -L https://pkgs.tailscale.com/stable/tailscale_1.76.1_arm64.tgz
curl -LO https://pkgs.tailscale.com/stable/tailscale_${TAILSCALE_VER}_arm64.tgz
tar xvzf tailscale_${TAILSCALE_VER}_arm64.tgz
rsync -a tailscale_${TAILSCALE_VER}_arm64/tailscale ~/vpn/
rsync -a tailscale_${TAILSCALE_VER}_arm64/tailscaled ~/vpn/
#chmod 700 {tailscale,tailscaled}
rm -r tailscale_${TAILSCALE_VER}_arm64
rm tailscale_${TAILSCALE_VER}_arm64.tgz

pip install homeassistant==2024.3.3

# run this manually:
# sudo ~/vpn/tailscaled -tun userspace-networking --state=$PREFIX/var/lib/tailscale/tailscaled.state -socket $PREFIX/var/run/tailscale/tailscaled.sock & sudo ~/vpn/tailscale --socket $PREFIX/var/run/tailscale/tailscaled.sock up --hostname=hymer
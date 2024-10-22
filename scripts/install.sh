#!/data/data/com.termux/files/usr/bin/sh
termux-wake-lock
termux-setup-storage
pkg update
pkg upgrade

# ssh
pkg install openssh
passwd #setting the password
sshd

pkg install termux-api tsu python rust binutils libjpeg-turbo build-essential cmake libopenblas pkg-config screen
pkg install python-cryptography python-numpy

mkdir /data/data/com.termux/files/home/scripts
cp ./hass.sh /data/data/com.termux/files/home/scripts/
cp ./update_ip.sh /data/data/com.termux/files/home/scripts/

mkdir /data/data/com.termux/files/home/.termux/boot/
cp ../termux/boot/ /data/data/com.termux/files/home/.termux/boot/

# VPN
curl -fsSL https://pkgs.tailscale.com/stable/tailscale_1.76.1_arm64.tgz | tar xz
mv tailscale_1.76.1_arm64/{tailscale,tailscaled} .
chmod 700 {tailscale,tailscaled}
rm -r tailscale_1.76.1_arm64
sudo ./tailscaled -tun userspace-networking --state=$PREFIX/var/lib/tailscale/tailscaled.state -socket $PREFIX/var/run/tailscale/tailscaled.sock
sudo ./tailscale --socket $PREFIX/var/run/tailscale/tailscaled.sock up --hostname=hymer
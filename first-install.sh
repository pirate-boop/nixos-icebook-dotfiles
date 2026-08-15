#!/usr/bin/env bash
set -euo pipefail
REPO="https://github.com/pirate-boop/nixos-icebook-dotfiles"
FLAKE="Kori-Icebook"
CFG="/mnt/etc/nixos"
[[ $EUID -eq 0 ]] || { echo "sudo bash $0"; exit 1; }

wipefs -a /dev/disk/by-partlabel/disk-main-ESP /dev/disk/by-partlabel/disk-main-swap /dev/disk/by-partlabel/disk-main-root
mkfs.vfat -F32 /dev/disk/by-partlabel/disk-main-ESP
mkswap /dev/disk/by-partlabel/disk-main-swap
mkfs.xfs -f /dev/disk/by-partlabel/disk-main-root
mount -t xfs -o noatime /dev/disk/by-partlabel/disk-main-root /mnt
mkdir -p /mnt/boot
mount -t vfat /dev/disk/by-partlabel/disk-main-ESP /mnt/boot

rm -rf "$CFG" /tmp/hwgen
git clone "$REPO" "$CFG"
nixos-generate-config --root /mnt --dir /tmp/hwgen
cp /tmp/hwgen/hardware-configuration.nix "$CFG/hardware-configuration.nix"
nixos-install --flake "$CFG#$FLAKE" --root /mnt

printf 'kori:donatwwww12\nroot:donatwwww12\n' | nixos-enter --root /mnt -- chpasswd

echo "=== ВСЁ ГОТОВО ==="
echo "Пароль установлен: donatwwww12"
echo "Введи: reboot"

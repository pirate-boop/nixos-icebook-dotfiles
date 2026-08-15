#!/usr/bin/env bash
# Безопасная установка Kori-Icebook.
# НЕ стирает диски и НЕ запускает disko — только монтирует существующие разделы.
set -euo pipefail

REPO="https://github.com/pirate-boop/nixos-icebook-dotfiles"
CFG="/tmp/cfg"
FLAKE="Kori-Icebook"

[[ $EUID -eq 0 ]] || { echo "Запускай от root: sudo bash $0"; exit 1; }

echo "=== Разделы (метки прошиты в дисках, они не меняются) ==="
lsblk -o NAME,SIZE,PARTLABEL || true
ls /dev/disk/by-partlabel || true
echo ""
echo "Этот скрипт НЕ форматирует диски. Он только смонтирует"
echo "disk-main-root/ESP и disk-second-data и установит систему."
read -r -p "Продолжить? Введи YES: " ANS
[[ "$ANS" == "YES" ]] || { echo "Отменено."; exit 1; }

mount -t xfs -o noatime /dev/disk/by-partlabel/disk-main-root /mnt
mkdir -p /mnt/boot /mnt/data
mount -t vfat /dev/disk/by-partlabel/disk-main-ESP /mnt/boot
mount -t xfs -o noatime /dev/disk/by-partlabel/disk-second-data /mnt/data

rm -rf "$CFG"
git clone "$REPO" "$CFG"

nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix "$CFG/hardware-configuration.nix"

nixos-install --flake "$CFG#$FLAKE" --root /mnt

echo "=== Готово ==="
echo "Пароль: nixos-enter --root /mnt  →  passwd  →  exit"
echo "Ребут: reboot"

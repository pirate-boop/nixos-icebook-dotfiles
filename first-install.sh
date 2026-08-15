#!/usr/bin/env bash
# Репродюсибельная установка через disko. Безопасность: disko видит один диск по серийнику.
set -euo pipefail

REPO="https://github.com/pirate-boop/nixos-icebook-dotfiles"
FLAKE="Kori-Icebook"
CFG="/mnt/etc/nixos"

[[ $EUID -eq 0 ]] || { echo "Запускай от root: sudo bash $0"; exit 1; }

echo "=== eui -> устройство ==="
ls -l /dev/disk/by-id | grep eui || true
lsblk -d -o NAME,SIZE,MODEL
DEV=$(readlink -f /dev/disk/by-id/nvme-eui.00000000000000000026b73844346fd5 || true)
echo "disko сотрёт ТОЛЬКО: $DEV (должен быть KINGSTON 931.5G)"
read -r -p "Продолжить? Введи YES: " ANS
[[ "$ANS" == "YES" ]] || { echo "Отменено."; exit 1; }

rm -rf /tmp/cfg
git clone "$REPO" /tmp/cfg

echo "=== ФАЗА 1: format ==="
nix --extra-experimental-features "nix-command flakes" \
  run "github:nix-community/disko/latest" -- --mode format --flake "/tmp/cfg#$FLAKE"

partprobe || true
udevadm settle || true
sleep 2
ls /dev/disk/by-partlabel | grep -q disk-main-root || {
  echo "Разделы не появились. Сделай sudo reboot и запусти скрипт ещё раз — это безопасно.";
  exit 1;
}

echo "=== ФАЗА 2: mount ==="
nix --extra-experimental-features "nix-command flakes" \
  run "github:nix-community/disko/latest" -- --mode mount --flake "/tmp/cfg#$FLAKE"

rm -rf "$CFG" /tmp/hwgen
git clone "$REPO" "$CFG"
nixos-generate-config --root /mnt --dir /tmp/hwgen
cp /tmp/hwgen/hardware-configuration.nix "$CFG/hardware-configuration.nix"

nixos-install --flake "$CFG#$FLAKE" --root /mnt

echo "=== Готово ==="
echo "Пароль: nixos-enter --root /mnt -> passwd -> exit"
echo "Ребут: reboot"

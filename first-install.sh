#!/usr/bin/env bash
# Чистая установка Kori-Icebook через disko.
# Запуск с live-флешки: sudo bash <этот-файл>
set -euo pipefail

REPO="https://github.com/pirate-boop/nixos-icebook-dotfiles"
CFG="/tmp/cfg"
FLAKE="Kori-Icebook"

[[ $EUID -eq 0 ]] || { echo "Запускай от root: sudo bash $0"; exit 1; }

echo "=== Диски в системе ==="
lsblk -d -o NAME,SIZE,MODEL || true
echo ""
echo "ВНИМАНИЕ: disko ПОЛНОСТЬЮ сотрёт оба диска!"
echo "disk1 (система) = /dev/nvme1n1, disk2 (Windows+data) = /dev/nvme0n1"
read -r -p "Продолжить? Введи YES: " ANS
[[ "$ANS" == "YES" ]] || { echo "Отменено."; exit 1; }

rm -rf "$CFG"
git clone "$REPO" "$CFG"

echo "=== Разметка и монтирование (disko) ==="
nix --extra-experimental-features "nix-command flakes" \
  run "github:nix-community/disko/latest" -- --flake "$CFG#$FLAKE"

echo "=== Генерирую свежий hardware-configuration с реальными UUID ==="
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix "$CFG/hardware-configuration.nix"

echo "=== Установка системы ==="
nixos-install --flake "$CFG#$FLAKE" --root /mnt

echo "=== Готово ==="
echo "Задать пароль до перезагрузки: nixos-enter --root /mnt"
echo "Перезагрузка: reboot"

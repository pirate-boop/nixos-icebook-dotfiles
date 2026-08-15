#!/usr/bin/env bash
# Чистая установка Kori-Icebook через disko. Запуск с live-флешки: sudo bash install.sh
set -euo pipefail

REPO="https://github.com/pirate-boop/nixos-icebook-dotfiles"
CFG="/tmp/cfg"
FLAKE="Kori-Icebook"

[[ $EUID -eq 0 ]] || { echo "Запускай: sudo bash install.sh"; exit 1; }

echo "=== Диски в системе (by-id) ==="
ls /dev/disk/by-id | grep -i nvme || true
echo ""
echo "ВНИМАНИЕ: disko ПОЛНОСТЬЮ сотрёт оба диска!"
echo "Убедись, что серийники в disko-config.nix совпадают с списком выше."
read -r -p "Продолжить? Введи YES: " ANS
[[ "$ANS" == "YES" ]] || { echo "Отменено."; exit 1; }

rm -rf "$CFG"
git clone "$REPO" "$CFG"

echo "=== Разметка и монтирование (disko) ==="
nix --extra-experimental-features "nix-command flakes" \
  run "github:nix-community/disko/latest" -- --flake "$CFG#$FLAKE"

echo "=== Установка системы ==="
nixos-install --flake "$CFG#$FLAKE" --root /mnt

echo "=== Готово ==="
echo "Задать пароль до перезагрузки: nixos-enter --root /mnt"
echo "Перезагрузка: reboot"

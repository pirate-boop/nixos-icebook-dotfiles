#!/usr/bin/env bash
# Kori first-install v2 — resumable
set -euo pipefail

REPO="https://github.com/pirate-boop/nixos-icebook-dotfiles"
HOST="Kori-Icebook"
USER="kori"
DISK="/dev/disk/by-id/nvme-eui.00000000000000000026b73844346fd5"

log() { echo -e "\n=== [first-install] $* ==="; }

# ---------- 0. Сеть ----------
if ! ping -c1 -W3 cache.nixos.org >/dev/null 2>&1; then
  log "Нет сети. Телефон воткнут по USB? Тетеринг должен подняться сам."
  echo "Если нужен Wi-Fi — в другом терминале: iwctl → station wlan0 connect SSID"
  read -rp "Жми Enter, когда сеть появится..."
fi

# ---------- 1. Конфиг ----------
[ -d /tmp/repo/.git ] || git clone "$REPO" /tmp/repo

# ---------- 2. Формат ----------
if blkid ${DISK}-part* 2>/dev/null | grep -q bcachefs && [ "${FORCE:-0}" != "1" ]; then
  log "bcachefs уже на диске — формат пропускаю (возобновление)"
else
  log "Форматирую диск (сотрёт всё)..."
  nix run github:nix-community/disko/latest -- --mode disko /tmp/repo/disko-config.nix
fi

# ---------- 3. Монтирование ----------
if ! mountpoint -q /mnt; then
  log "Монтирую разделы..."
  nix run github:nix-community/disko/latest -- --mode mount /tmp/repo/disko-config.nix
fi

# ---------- 4. Кеши ----------
mkdir -p /mnt/.nix-cache
export XDG_CACHE_HOME=/mnt/.nix-cache
export NIX_CONFIG="
extra-substituters = https://nyx-cache.chaotic.cx https://nix-community.cachix.org https://kori-cachix.cachix.org
extra-trusted-public-keys = nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= kori-cachix.cachix.org-1:lvfvhLRZaSiGOD8HO3C3Ji2LHzixWRI2B2l0dyYoQ3g=
"

# ---------- 5. Конфиг на диск ----------
if [ ! -d /mnt/etc/nixos/.git ]; then
  log "Кладу конфиг в /mnt/etc/nixos..."
  mkdir -p /mnt/etc/nixos
  cp -r /tmp/repo/. /mnt/etc/nixos/
fi

# ---------- 6. Установка ----------
log "Ставлю NixOS (спросит root пароль)..."
nixos-install --root /mnt --flake "/mnt/etc/nixos#$HOST"

# ---------- 7. Пароль пользователя ----------
log "Задаю пароль для пользователя $USER..."
chroot /mnt passwd "$USER"

log "ГОТОВО. Ребутай: reboot"

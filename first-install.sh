#!/usr/bin/env bash
#****************************************************************#
# |============================================================| #
# |FIRST INSTALL — Kori-PC NixOS                               | #
# |============================================================| #
#  Запуск: bash first-install.sh                                  #
#  Предполагается что:                                            #
#  1. NixOS уже установлен (nixos-install прошёл)                 #
#  2. Ты залогинен как kori или root                              #
#  3. Интернет есть                                               #
#****************************************************************#

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

info()    { echo -e "${CYAN}[INFO]${NC} $*"; }
success() { echo -e "${GREEN}[OK]${NC} $*"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $*"; }
die()     { echo -e "${RED}[FAIL]${NC} $*"; exit 1; }

REPO="https://github.com/pirate-boop/nixdeck-config"  # TODO: создай отдельное репо для ПК
NIXOS_DIR="/etc/nixos"
CONFIG_NAME="KORI-PC"

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║        Kori-PC — NixOS First Install             ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# ── Шаг 1: Проверки ──────────────────────────────────────────────
info "Проверяю окружение..."
[[ $EUID -eq 0 ]] || die "Запускай от root: sudo bash first-install.sh"
command -v git  &>/dev/null || die "git не найден — установи: nix-shell -p git"
command -v curl &>/dev/null || die "curl не найден"

# ── Шаг 2: Клонируем конфиг ──────────────────────────────────────
info "Клонирую конфиг в $NIXOS_DIR ..."
if [[ -d "$NIXOS_DIR/.git" ]]; then
  warn "$NIXOS_DIR уже является git репо — делаю git pull"
  git -C "$NIXOS_DIR" pull
else
  # Бэкапим сгенерированные файлы
  cp "$NIXOS_DIR/hardware-configuration.nix" /tmp/hardware-configuration.nix 2>/dev/null || \
    warn "hardware-configuration.nix не найден — сгенерирую сам"

  rm -rf "$NIXOS_DIR"
  git clone "$REPO" "$NIXOS_DIR"

  # Возвращаем hardware-configuration.nix
  if [[ -f /tmp/hardware-configuration.nix ]]; then
    cp /tmp/hardware-configuration.nix "$NIXOS_DIR/hardware-configuration.nix"
    success "hardware-configuration.nix восстановлен"
  else
    info "Генерирую hardware-configuration.nix ..."
    nixos-generate-config --show-hardware-config > "$NIXOS_DIR/hardware-configuration.nix"
    success "hardware-configuration.nix сгенерирован"
  fi
fi

# ── Шаг 3: Git safe directory ────────────────────────────────────
git config --global --add safe.directory "$NIXOS_DIR"

# ── Шаг 4: Проверяем flake ───────────────────────────────────────
info "Проверяю flake..."
cd "$NIXOS_DIR"
nix flake check --no-build 2>&1 | tail -5 || warn "flake check упал — продолжаю, посмотрим на rebuild"

# ── Шаг 5: Первый nixos-rebuild ──────────────────────────────────
info "Запускаю nixos-rebuild switch --flake $NIXOS_DIR#$CONFIG_NAME ..."
echo "Это займёт несколько минут при первом запуске (скачиваем пакеты)..."
echo ""

nixos-rebuild switch --flake "$NIXOS_DIR#$CONFIG_NAME" 2>&1 | tee /tmp/nixos-rebuild.log

if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
  success "nixos-rebuild прошёл успешно!"
else
  die "nixos-rebuild упал. Лог: /tmp/nixos-rebuild.log"
fi

# ── Шаг 6: Waydroid инициализация ────────────────────────────────
info "Инициализирую Waydroid..."
if command -v waydroid &>/dev/null; then
  waydroid init -s GAPPS -f 2>/dev/null || \
    warn "waydroid init упал (возможно уже инициализирован или нет интернета)"
else
  warn "waydroid не найден в PATH — пропускаю"
fi

# ── Шаг 7: Libvirtd сеть ─────────────────────────────────────────
info "Настраиваю сеть libvirtd..."
virsh net-autostart default 2>/dev/null || warn "virsh: не удалось настроить default сеть"
virsh net-start default 2>/dev/null     || warn "virsh: default сеть уже запущена или ошибка"

# ── Шаг 8: Бэкап hardware-configuration.nix в репо ───────────────
info "Добавляю hardware-configuration.nix в репо..."
if [[ -f "$NIXOS_DIR/hardware-configuration.nix" ]]; then
  # Не коммитим — это машинно-специфичный файл, просто информируем
  warn "hardware-configuration.nix НЕ добавляется в git (машинно-специфичный)"
  warn "Если хочешь — добавь вручную: git add hardware-configuration.nix && git commit"
fi

# ── Финал ─────────────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║                   ГОТОВО                        ║"
echo "╠══════════════════════════════════════════════════╣"
echo "║  Следующие шаги:                                 ║"
echo "║  1. Перезагрузить систему: reboot                ║"
echo "║  2. Войти через SDDM → Hyprland                  ║"
echo "║  3. illogical-impulse запустится автоматически   ║"
echo "║  4. Настроить обои через swww/hyprpaper           ║"
echo "║  5. Установить игры через Steam (уже включён)    ║"
echo "║  6. ZZZ/HSR — через Lutris вручную               ║"
echo "║  7. Для Windows VM — virt-manager готов          ║"
echo "╠══════════════════════════════════════════════════╣"
echo "║  Алиасы:  alisa   — хэндбук                     ║"
echo "║           rebuild — быстрый rebuild              ║"
echo "║           gc      — очистить /nix/store          ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

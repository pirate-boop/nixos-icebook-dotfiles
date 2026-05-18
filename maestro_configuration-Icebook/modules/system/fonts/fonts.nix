#****************************************************************#
# |============================================================| #
# |FONTS                                                       | #
# |============================================================| #
#  Шрифты нужные illogical-impulse: rubik, nerd-fonts.ubuntu,    #
#  nerd-fonts.jetbrains-mono + Material Symbols (авто через flake)#
#****************************************************************#
{ pkgs, ... }: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # ── Основные ──────────────────────────────────
      noto-fonts
      noto-fonts-color-emoji  # НЕ noto-fonts-emoji (сломает иконки)
      noto-fonts-cjk-sans     # Японский/Китайский/Корейский

      # ── Nerd Fonts ────────────────────────────────
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono  # нужен illogical-impulse
      nerd-fonts.ubuntu          # нужен illogical-impulse
      nerd-fonts.noto            # резерв

      # ── UI шрифты (illogical-impulse) ─────────────
      rubik                   # основной UI шрифт illogical

      # ── Прочие ────────────────────────────────────
      inter
      source-code-pro
      liberation_ttf          # замена Arial/Times/Courier
      nerd-fonts.symbols-only
    ];

    fontconfig = {
      defaultFonts = {
        serif     = [ "Noto Serif" "Liberation Serif" ];
        sansSerif = [ "Inter" "Noto Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" "FiraCode Nerd Font" ];
        emoji     = [ "Noto Color Emoji" ];
      };
    };
  };
}  

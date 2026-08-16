{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # ── Основной терминал ─────────────────────────
    #nur.repos.nakido.tabby     # Tabby Terminal через NUR
                               # (требует NUR overlay в nixpkgs.nix)

    # ── Shell утилиты ─────────────────────────────
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    oh-my-zsh
    starship                   # промпт

    # ── Мультиплексор ─────────────────────────────
    #zellij                     # tmux-замена, удобнее для начала

    # Резерв если tabby не встанет:
    # foot                     # легковесный Wayland терминал
    # kitty                    # быстрый GPU-ускоренный
    #ghostty
    wezterm
  ];
}

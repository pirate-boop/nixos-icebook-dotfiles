# niri_utils.nix
{ ... }: {
  programs.zsh.shellAliases = {
    nw   = "niri msg outputs";
    ws   = "niri msg workspaces";
    win  = "niri msg windows";
    act  = "niri msg action";
    qui  = "niri msg action quit";
    tki  = "niri msg action toggle-keyboard-shortcuts-inhibit";
    dst  = "niri msg action do-screen-transition";

    # Скриншоты
    ns   = "niri msg action screenshot";
    nss  = "niri msg action screenshot-screen";
    nsw  = "niri msg action screenshot-window";
  };
}

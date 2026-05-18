{ ... }: {
  imports = [
    ./editor.nix
    ./visual.nix
    ./browser.nix
    ./terminal.nix
    ./file-manager.nix
    ./pager.nix
    ./bat-theme.nix
    ./fzf.nix
    ./gtk-portal.nix
    ./thunar-plagins.nix
  ];
}

{ ... }: {
  imports = [
    ./git.nix
    ./zsh.nix
    ./vscodium.nix
    ./starship.nix
    ./hyprlock.nix
    ./yazi.plugins.nix
    ./rust-language.nix
    ./niri-focus.nix
  ];
}

# CLI_navigation.nix
{ ... }: {
  programs.zsh.shellAliases = {
    ll    = "eza -la --icons --git --group-directories-first";
    la    = "eza -a --icons";
    lt    = "eza --tree --icons -L 2";
    ".."  = "cd ..";
    "..." = "cd ../..";
  };
}

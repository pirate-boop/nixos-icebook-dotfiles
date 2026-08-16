# waydroid_utils.nix
{ ... }: {
  programs.zsh.shellAliases = {
    wstart = "waydroid session start";
    wstop  = "waydroid session stop";
    wui    = "waydroid show-full-ui";
  };
}

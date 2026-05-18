# hypr_utils.nix
{ ... }: {
  programs.zsh.shellAliases = {
    hypr_reload = "hyprctl reload";
    hypr_mon    = "hyprctl monitors";
    hypr_cl     = "hyprctl clients";
  };
}

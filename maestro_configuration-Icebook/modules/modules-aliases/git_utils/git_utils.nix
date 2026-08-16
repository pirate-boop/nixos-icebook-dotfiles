# git_utils.nix
{ ... }: {
  programs.zsh.shellAliases = {
    gs  = "git status";
    ga  = "git add";
    gc_ = "git commit -m";
    gp  = "git push";
    gl  = "git log --oneline --graph";
  };
}

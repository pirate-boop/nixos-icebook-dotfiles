# logs_info.nix
{ ... }: {
  programs.zsh.shellAliases = {
    jctl  = "journalctl -xe";
    jctlu = "journalctl -xe -u";
    jf    = "journalctl -f";
  };
}

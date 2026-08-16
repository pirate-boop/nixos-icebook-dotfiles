# network_info_utils.nix
{ ... }: {
  programs.zsh.shellAliases = {
    myip  = "curl -s https://ifconfig.me";
    ping8 = "ping 8.8.8.8";
  };
}

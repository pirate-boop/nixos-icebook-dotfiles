# system_info_utils.nix
{ ... }: {
  programs.zsh.shellAliases = {
    fetch    = "fastfetch";
    sysinfo  = "inxi -Fzx";
    temps    = "watch -n 2 sensors";
    gpu      = "nvidia-smi";
    gpuwatch = "watch -n 1 nvidia-smi";
    mem      = "free -h";
    disk     = "df -h";
    ports    = "ss -tulnp";
    psg      = "ps aux | grep";
    kill9    = "kill -9";
  };
}

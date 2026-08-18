{ ... }: {
  imports = [
    ./system-info-ctrl.nix
    ./disk.nix
    ./fetch.nix
    ./kill9.nix
    ./mem.nix
    ./ports.nix
    ./psg.nix
    ./sysinfo.nix
    ./temps.nix
  ];
}

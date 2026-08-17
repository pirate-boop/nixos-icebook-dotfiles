{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "nix-ctrl";
      text = ''
        echo "=== NIX ==="
        echo "nix-ttt                        — cd /etc/nixos + ttt"
        echo ""
        echo "=== REBUILD ==="
        echo "kori-rebuild-switch            — nixos-rebuild switch"
        echo "kori-rebuild-switch-log        — switch с --show-trace"
        echo "kori-rebuild-switch-save-log   — switch, log in ~/Documents/nix-log in case of error"
        echo "kori-rebuild-boot              — nixos-rebuild boot"
        echo "kori-rebuild-boot-log          — boot с --show-trace"
        echo "kori-rebuild-boot-save-log     — boot, лог в ~/Documents/nix-log in case of error"
      '';
    })
  ];
}

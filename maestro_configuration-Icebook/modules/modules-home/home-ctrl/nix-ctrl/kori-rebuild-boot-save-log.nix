{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "kori-rebuild-boot-save-log";
      runtimeInputs = [ pkgs.coreutils ];
      text = ''
        set -euo pipefail
        LOGDIR="$HOME/Documents/nix-log"
        mkdir -p "$LOGDIR"
        H=$(date +%s | sha256sum | cut -c1-8)
        T=$(mktemp)
        if sudo nixos-rebuild boot --flake "/etc/nixos#$(hostname)" --show-trace 2>&1 | tee "$T"; then
          rm -f "$T"; echo "ok"
        else
          mv "$T" "$LOGDIR/$H.log"; echo "fail: $LOGDIR/$H.log"; exit 1
        fi
      '';
    })
  ];
}

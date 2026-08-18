# === modules-home/home-ctrl/jj-ctrl/jj-cm.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "jj-cm";
      runtimeInputs = [ pkgs.jujutsu pkgs.git pkgs.gnugrep ];
      text = ''
        J=${pkgs.jujutsu}/bin/jj
        if $J diff --summary | grep -q .; then
          H=$($J diff --git | sync-hash)
          $J commit -m "sync-$H"
        else
          echo "нечего коммитить"
        fi
      '';
    })
  ];
}

{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "jj-cm";
      runtimeInputs = [ pkgs.jujutsu pkgs.git pkgs.coreutils pkgs.gnugrep ];
      text = ''
        J=${pkgs.jujutsu}/bin/jj
        if $J diff --summary | grep -q .; then
          H=$($J log -r @ -T 'change_id.short(8)' --no-graph)
          $J commit -m "sync-$H"
        else
          echo "нечего коммитить"
        fi
      '';
    })
  ];
}

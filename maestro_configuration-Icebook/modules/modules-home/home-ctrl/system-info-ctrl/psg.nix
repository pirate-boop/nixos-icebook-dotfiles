{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "psg";
      runtimeInputs = [ pkgs.procps pkgs.gnugrep ];
      text = ''
        # shellcheck disable=SC2009
        ps aux | grep --color=auto "$@"
      '';
    })
  ];
}

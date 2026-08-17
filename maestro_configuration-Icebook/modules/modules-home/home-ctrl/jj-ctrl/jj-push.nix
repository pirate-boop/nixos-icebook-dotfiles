{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "jj-push";
      runtimeInputs = [ pkgs.jujutsu pkgs.git ];
      text = ''
        ${pkgs.jujutsu}/bin/jj git push -b main
      '';
    })
  ];
}

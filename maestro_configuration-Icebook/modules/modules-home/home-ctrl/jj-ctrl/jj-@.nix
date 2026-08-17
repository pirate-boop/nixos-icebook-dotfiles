{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "jj-@";
      runtimeInputs = [ pkgs.jujutsu ];
      text = ''
        ${pkgs.jujutsu}/bin/jj bookmark set main -r @-
      '';
    })
  ];
}

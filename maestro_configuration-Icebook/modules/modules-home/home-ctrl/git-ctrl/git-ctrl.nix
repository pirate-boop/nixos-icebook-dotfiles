{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "git-ctrl";
      text = ''
        echo "gs    — git status"
        echo "ga    — scan dir"
        echo "gc    — commit with hash (if changes existing "
        echo "gp  — git push main"
      '';
    })
  ];
}

{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "jj-ctrl";
      text = ''
        echo "jj-cm    — commit with hash (if changes existing)"
        echo "jj-@     — bookmark set main -r @-"
        echo "jj-push  — git push -b main"
      '';
    })
  ];
}

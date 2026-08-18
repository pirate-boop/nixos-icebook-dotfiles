# === modules-home/home-ctrl/git-ctrl/gc.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "gc";
      runtimeInputs = [ pkgs.git pkgs.coreutils ];
      text = ''
        if [ -n "$(git status --porcelain)" ]; then
          git add -A
          H=$(git diff --cached | sha256sum | cut -c1-8)
          git commit -m "sync-$H"
        else
          echo "нечего коммитить"
        fi
      '';
    })
  ];
}

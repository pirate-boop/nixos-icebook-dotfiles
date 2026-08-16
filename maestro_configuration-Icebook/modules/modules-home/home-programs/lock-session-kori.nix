{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "lock-session-kori" ''
      ${pkgs.niri}/bin/niri msg action switch-layout 0
      noctalia msg session lock
    '')
  ];
}

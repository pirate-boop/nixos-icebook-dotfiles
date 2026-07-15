{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "lock-session-kori" ''
      ${pkgs.niri}/bin/niri msg action set-layout-index 0
      dms ipc call lock lock
    '')
  ];
}

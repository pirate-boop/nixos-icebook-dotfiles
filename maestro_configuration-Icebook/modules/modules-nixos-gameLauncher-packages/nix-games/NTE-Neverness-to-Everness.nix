{ config, pkgs, inputs, ... }:

{
  games.neverness-to-everness = {
    enable = true;
    desktopName = "Neverness to Everness";
    exePath = "/home/kori/Games/nixos-Games/NTE: Neverness to Everness/drive_c/Program Files/Neverness To Everness/NTEGlobalLauncher.exe";
    prefixPath = "/home/kori/Games/nixos-Games/NTE: Neverness to Everness";

    # Explicitly specify which Proton flavor to use from your proton-flavors input
    proton = inputs.proton-flavors.packages.${pkgs.system}.proton-ge;

    anticheat = "easyanticheat";
    prefixType = "gacha";
    authWorkaroundVerb = "webview2";
    gamemode = true;
    mangohud = false;
  };
}

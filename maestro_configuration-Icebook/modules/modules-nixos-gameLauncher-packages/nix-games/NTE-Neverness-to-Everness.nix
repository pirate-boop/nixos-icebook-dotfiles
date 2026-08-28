{ config, lib, pkgs, inputs ? {}, ... }:

{
  games.neverness-to-everness = {
    enable = true;
    desktopName = "Neverness to Everness";

    # Path to the game launcher executable
    exePath = "/home/kori/Games/nixos-Games/NTE: Neverness to Everness/drive_c/Program Files/Neverness To Everness/NTEGlobalLauncher.exe";

    # Existing Wine prefix directory
    prefixPath = "/home/kori/Games/nixos-Games/NTE: Neverness to Everness";

    # Proton runner package selection
    # Leave commented to use default from proton-flavors input, or specify explicitly:
    proton = inputs.proton-flavors.packages.${pkgs.system}.proton-ge;

    # Anti-cheat integration switch
    # Triggers umu-run execution container if EAC/BattlEye is present.
    # Set to "easyanticheat" if the release uses EAC, or null if direct Proton execution is required.
    anticheat = "easyanticheat";

    # Winetricks preset for gacha launchers (corefonts, vcrun2022, physx)
    prefixType = "gacha";

    # Fix for OAuth / embedded browser login window
    authWorkaroundVerb = "webview2";

    # Performance and system integration flags
    gamemode = true;
    mangohud = true;
    preventSleep = true;

    # Optional environment variables
    extraEnv = {
      "DXVK_HUD" = "compiler";
    };
  };
}

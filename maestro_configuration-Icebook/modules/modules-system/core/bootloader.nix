# |****************************************************************************| #
# |============================================================================| #
# |BOOTLOADER — GRUB2 + Persona 5 Navi theme                                   | #
# |============================================================================| #
# | Bootloader: GRUB2 (EFI, Persona 5 Royal - Navi theme)                      | #
# | Rollback: Last 10 generations in the GRUB menu                             | #
# | Device: nodev (EFI mode, not BIOS)                                         | #
# |****************************************************************************| #
{ pkgs, ... }: {
  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot";       # explicitly specify, needed for GRUB
    };

    timeout = 10;

    systemd-boot.enable = false;        

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      efiInstallAsRemovable = true;

      configurationLimit = 10;

      # Persona 5 Royal — Navi theme
      # fetchzip strips ./navi/ → theme.txt is located directly in the store path
      theme = pkgs.fetchzip {
        url = "https://github.com/SiriusAhu/Persona_5_Royal_Grub_Themes/releases/download/v1.0/navi.tar.gz";
        sha256 = "0zd3yh04xg44vp4v7a03kv1p0nwlk2clkn1r0jimnd8sxxvqbalg";
      };
    };
  };
}

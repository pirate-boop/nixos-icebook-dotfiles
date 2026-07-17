#****************************************************************#
# |============================================================| #
# |SYSTEM PACKAGES — дирижёр                                   | #
# |============================================================| #
{ ... }: {
  imports = [
    ./system_monitoring-tools.nix
    ./cli-tools.nix
    ./terminal-app.nix
    ./browser-apps.nix
    ./media-apps.nix
    ./gaming-apps.nix
    ./social-apps.nix
    ./virt-tools.nix
    ./system-DE.nix
    ./nix-ld-libraries.nix
    ./archive-extractor_tools.nix
    ./code-editors_tools.nix
    ./desktop-utils.nix
    ./file-manager_tools.nix
    ./network_security.nix
    ./vpn_clients.nix
    ./libreoffice.nix
    #./zen-browser.nix
    ./nirimod.nix
    #./lfff.nix
    ./WaydroiSU.nix
   ./waydroid-extra.nix
   #./flatpak.nix
   ./offensive-wifitools.nix
   ./scrcpy-gui.nix
   #./noctalia-shell-dev.nix
   ./ttt.nix
  ];
}

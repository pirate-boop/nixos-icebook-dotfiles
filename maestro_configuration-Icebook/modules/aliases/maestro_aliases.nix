#****************************************************************#
# |============================================================| #
# |ALIASES — дирижёр                                           | #
# |============================================================| #
{ ... }: {
  imports = [
    ./colors.nix                                            # Colors for all alisa_* files
    ./alisa-panel.nix                                       # General menu (command alisa)
    ./git_utils/maestro_git_utils.nix                       # File importer
    ./nix-management_utils/maestro_nix-management_utils.nix # File importer
    ./logs_info_utils/maestro_logs_info.nix                 # File importer
    ./CLI_navigation_utils/maestro_CLI_navigation.nix       # File importer
    ./system_info_utils/maestro_system_info_utils.nix       # File importer
    ./network_info_utils/maestro_network_info_utils.nix     # File importer
    ./hypr_utils/maestro_hypr_utils.nix                     # File importer
    ./waydroid_utils/maestro_waydroid_utils.nix             # File importer
    ./niri_utils/maestro_niri_utils.nix                     # File importer
  ];
}

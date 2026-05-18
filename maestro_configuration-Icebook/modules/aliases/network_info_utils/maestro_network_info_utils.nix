# ++orch++network_info_utils.nix
{ ... }: {
  imports = [
    ./network_info_utils.nix        # Сами алиасы (myip, ping8)
    ./alisa_network_info_utils.nix  # Справочник (alisa_network)
  ];
}

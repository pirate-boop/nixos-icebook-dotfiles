# ++orch++system_info_utils.nix
{ ... }: {
  imports = [
    ./system_info_utils.nix        # Команды (fetch, gpu, mem...)
    ./alisa_system_info_utils.nix  # Справочник (alisa_system)
  ];
}

# ++orch++CLI_navigation.nix
{ ... }: {
  imports = [
    ./CLI_navigation.nix        # Сами алиасы (ll, la, lt...)
    ./alisa_CLI_navigation.nix  # Справочник (alisa_cli)
  ];
}

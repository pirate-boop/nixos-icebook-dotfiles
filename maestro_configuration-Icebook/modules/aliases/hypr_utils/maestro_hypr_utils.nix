# ++orch++hypr_utils.nix
{ ... }: {
  imports = [
    ./hypr_utils.nix        # Сами алиасы (hypr_reload, hypr_mon...)
    ./alisa_hypr_utils.nix  # Справочник (alisa_hypr)
  ];
}

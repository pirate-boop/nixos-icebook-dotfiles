# ++orch++waydroid_utils.nix
{ ... }: {
  imports = [
    ./waydroid_utils.nix        # Сами алиасы (wstart, wstop, wui)
    ./alisa_waydroid_utils.nix  # Справочник (alisa_waydroid)
  ];
}

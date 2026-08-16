# ++orch++niri_utils.nix
{ ... }: {
  imports = [
    ./niri_utils.nix        # Сами алиасы (nw, ws, win, ns...)
    ./alisa_niri_utils.nix  # Справочник (alisa_niri)
  ];
}

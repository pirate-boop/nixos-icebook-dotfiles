# ++orch++logs_info.nix
{ ... }: {
  imports = [
    ./logs_info.nix        # Сами команды (jctl, jf...)
    ./alisa_logs_info.nix  # Справочник (alisa_logs)
  ];
}

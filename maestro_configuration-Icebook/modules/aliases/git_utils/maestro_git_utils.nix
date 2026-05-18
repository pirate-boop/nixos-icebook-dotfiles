# ++orch++git_utils.nix
{ ... }: {
  imports = [
    ./git_utils.nix        # Сами команды (gs, ga, gp...)
    ./alisa_git_utils.nix  # Справочник (alisa_git)
  ];
}

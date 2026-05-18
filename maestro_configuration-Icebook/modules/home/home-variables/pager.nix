{ ... }: {
  home.sessionVariables = {
    PAGER   = "bat";
    MANPAGER = "sh -c 'col -bx | bat -l man'";
  };
}

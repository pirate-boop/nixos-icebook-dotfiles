{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      user.name  = "pirate-boop";
      user.email = "daniilignatev290@proton.me";
      init.defaultBranch = "main";
    };
  };
}

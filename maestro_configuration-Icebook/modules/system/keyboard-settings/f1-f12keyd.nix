{ ... }: {
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          f1 = "sleep";
          f2 = "brightnessdown";
          f3 = "brightnessup";
          f6 = "mute";
          f7 = "volumedown";
          f8 = "volumeup";
        };
      };
    };
  };
}

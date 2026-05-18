{ inputs, ... }: {
  services.displayManager.sddm.enable = false;
  imports = [ inputs.sysc-greet.nixosModules.default ];
  services.sysc-greet = {
    enable = true;
    compositor = "niri";
  };
}

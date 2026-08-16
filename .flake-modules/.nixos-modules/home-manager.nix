{ inputs, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager.useGlobalPkgs    = true;
  home-manager.useUserPackages  = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.users.kori =
    "${inputs.self}/maestro_configuration-Icebook/modules/modules-home/maestro_modules-home.nix";
}

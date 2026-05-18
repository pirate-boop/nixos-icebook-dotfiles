{ inputs, ... }: {
  flake.nixosConfigurations.Kori-Icebook = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      ../.nixos-modules/maestro_nixos-modules.nix
    ];
  };
}

{ inputs, ... }: {
  imports = [
    inputs.disko.nixosModules.disko
    "${inputs.self}/disko-config.nix"
  ];
  disko.enableConfig = true;
}

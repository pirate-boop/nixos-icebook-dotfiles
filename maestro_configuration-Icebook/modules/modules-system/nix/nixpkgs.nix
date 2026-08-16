{ self, inputs, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;           # Steam, Chrome, Discord и т.д.
    config.permittedInsecurePackages = [];

    overlays = [
      inputs.nur.overlays.default               # NUR: pkgs.nur.repos.*
      inputs.chaotic.overlays.default  # CachyOS ядро + свежий софт
      (final: prev: {
        openldap = prev.openldap.overrideAttrs (old: {
          doCheck = false;
          doInstallCheck = false;
          checkPhase = "true";
          installCheckPhase = "true";
        });
      })
    ];
  };
}

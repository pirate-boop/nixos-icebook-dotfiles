{
  nix.settings = {
    substituters = [ "https://kori-cachix.cachix.org" ];
    trusted-public-keys = [ "kori-cachix.cachix.org-1:ТВОЙ_ПУБЛИЧНЫЙ_КЛЮЧ_ИЗ_CACHIX" ];
  };
}

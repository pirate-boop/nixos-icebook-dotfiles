{ ... }: {
  nix.settings = {
    substituters = [ "https://nix.chaotic.cx/nix" ];
    trusted-public-keys = [ "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8=" ];
  };
}

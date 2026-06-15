{
  description = "Kori NixOS Config — LAPTOP (Ryzen 7 8845HS + Radeon 780M, Niri + Noctalia)";

  inputs = {
    flake-parts.url     = "github:hercules-ci/flake-parts";
    nixpkgs.url         = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url           = "github:nix-community/disko/latest";
    home-manager        = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nur                 = { url = "github:nix-community/NUR"; inputs.nixpkgs.follows = "nixpkgs"; };
    chaotic             = { url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; inputs.nixpkgs.follows = "nixpkgs"; };
    zen-browser         = { url = "github:0xc000022070/zen-browser-flake"; inputs.nixpkgs.follows = "nixpkgs"; };
    nirimod             = { url = "github:srinivasr/nirimod"; inputs.nixpkgs.follows = "nixpkgs"; };
    sysc-greet          = { url = "github:Nomadcxx/sysc-greet"; inputs.nixpkgs.follows = "nixpkgs"; };
    lfff                = { url = "github:mrFrok/LibreFastbootFirmwareFlasher"; inputs.nixpkgs.follows = "nixpkgs"; };
    waydroid-script     = { url = "github:casualsnek/waydroid_script"; inputs.nixpkgs.follows = "nixpkgs"; };
    anime-cursors.url   = "github:pirate-boop/anime-cursors";
    scrcpy-gui          = { url = "github:kil0bit-kb/scrcpy-gui"; inputs.nixpkgs.follows = "nixpkgs"; };
    noctalia.url        = "github:noctalia-dev/noctalia";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./.flake-modules/maestro_flake-modules.nix
      ];
      systems = [ "x86_64-linux" ];
    };
}

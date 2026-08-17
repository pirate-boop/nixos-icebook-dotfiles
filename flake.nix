{
  description = "Kori NixOS Config — LAPTOP (Ryzen 7 8845HS + Radeon 780M, Niri + Noctalia)";

  inputs = {
    flake-parts.url     = "github:hercules-ci/flake-parts";
    nixpkgs.url         = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url           = "github:nix-community/disko/latest";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager        = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    nur                 = { url = "github:nix-community/NUR"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    chaotic             = { url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    zen-browser         = { url = "github:youwen5/zen-browser-flake"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    nirimod             = { url = "github:srinivasr/nirimod"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    # sysc-greet          = { url = "github:Nomadcxx/sysc-greet"; inputs.nixpkgs.follows = "nixpkgs"; };
    lfff                = { url = "github:mrFrok/LibreFastbootFirmwareFlasher"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    waydroid-script     = { url = "github:casualsnek/waydroid_script"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    anime-cursors       = { url = "github:pirate-boop/anime-cursors"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    scrcpy-gui          = { url = "github:kil0bit-kb/scrcpy-gui"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    noctalia            = { url = "github:noctalia-dev/noctalia"; inputs.nixpkgs.follows = "nixpkgs-unstable"; }; 
    noctalia-greeter    = { url = "github:noctalia-dev/noctalia-greeter"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    ttt                 = { url = "github:eugenioenko/ttt"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    bun2nix             = { url = "github:nix-community/bun2nix"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };              
    #ayugram-desktop    = { url = "github:ndfined-crp/ayugram-desktop"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    mangowm             = { url = "github:mangowm/mango"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    dms                 = { url = "github:AvengeMedia/DankMaterialShell/stable"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./.flake-modules/maestro_flake-modules.nix
      ];
      systems = [ "x86_64-linux" ];
      
      perSystem = {pkgs, ... }: {
        packages.iso = inputs.nixpkgs.legasyPackages.x86_64-linux.nixos [
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ./maestro_configuration-Icebook/modukes/modules-system/core/bcachefs.nix
        ];
    };
}

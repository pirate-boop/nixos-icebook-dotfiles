# noutube-overlay.nix
{ inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.noutube.overlays.default
  ];
}

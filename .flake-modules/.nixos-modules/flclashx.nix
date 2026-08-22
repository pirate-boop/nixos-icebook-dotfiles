{ inputs, ... }: {
  nixpkgs.overlays = [
    inputs.flclashx.overlays.default
  ];
}

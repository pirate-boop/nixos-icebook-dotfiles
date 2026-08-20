{ inputs, ... }: {
  nixpkgs.overlays = [
    inputs.vivaldi.overlays.default
  ];
}

{ pkgs, inputs, ... }: {
    environment.systemPackages = [
        inputs.ayugram-desktop.packages.${pkgs.system}.default
    ];
}

{inputs, pkgs, ... }: {
    environment.systemPackages = [
        inputs.nirimod.packages.${pkgs.system}.default
    ];
}

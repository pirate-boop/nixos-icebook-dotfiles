{inputs, pkgs, ... }: {
    environment.systemPackages = [
        input.nirimod.packages.${pkgs.system}.default
    ];
}

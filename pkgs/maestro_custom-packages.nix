{ pkgs, ... }:

{
  # disabled-by-restore: fptn-vpn.nix написан как callPackage-функция, а подключён модулем.
  # Вернуть после починки шапки файла (см. мой чат).
  # imports = [ ./fptn-vpn.nix ];

  environment.systemPackages = [
    (pkgs.callPackage ./zen-browser.nix { })
    (pkgs.callPackage ./noutube-desktop.nix { })
    # disabled-by-restore: пустой hash + wrapGAppsHook3. Вернуть после:
    # 1) в nativeBuildInputs wrapGAppsHook3 -> wrapGAppsHook
    # 2) hash вставить через nix-prefetch-url
    # (pkgs.callPackage ./onlyoffice.nix { })
  ];
}

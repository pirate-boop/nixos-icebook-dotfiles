#****************************************************************#
  # |============================================================| #
  # |SOCIAL-APPS                                                 | #
  # |============================================================| #
  #****************************************************************#
{ pkgs, ... }: {
  #nixpkgs.config.permittedInsecurePackages = [
  #  "electron-40.10.5"
  #];

  environment.systemPackages = with pkgs; [
    # telegram-desktop     
    # discord              # тоже самое блять
    # element-desktop      # Matrix (опционально) твое очко опционально claude
    ayugram-desktop        # Desktop Telegram client with good customization and Ghost mode
    #fluffychat             # Chat with your friends (matrix client)
    # vencord
    # vesktop
    # thunderbird
    # protonmail-bridge  # если нужен Proton
  ];
}

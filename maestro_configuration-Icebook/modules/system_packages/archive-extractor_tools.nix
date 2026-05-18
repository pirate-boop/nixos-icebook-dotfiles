{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # kdePackages.ark          # GUI архиватор (KDE, работает без KDE).
    p7zip                    # New p7zip fork with additional codecs and improvements.
    zip                      # Compressor/archiver for creating and modifying zipfiles
    unzip                    # Extraction utility for archives compressed in .zip format
    gzip                     # GNU zip compression program
    bzip2                    # High-quality data compression program
    xz                       # General-purpose data compression software, successor of LZMA
    file-roller
    # thunar-archive-plugin
  ];
}

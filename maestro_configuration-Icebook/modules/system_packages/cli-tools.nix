{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gh
    git                      # Distributed version control system
    wget                     # Tool for retrieving files using HTTP, HTTPS, and FTP
    curlFull                 # Command line tool for transferring files with URL syntax
    bat                      # Cat(1) clone with syntax highlighting and Git integration
    eza                      # Modern, maintained replacement for ls
    fd                       # Simple, fast and user-friendly alternative to find
    ripgrep                  # Utility that combines the usability of The Silver Searcher with the raw speed of grep
    fzf                      # Command-line fuzzy finder written in Go
    tree                     # Command to produce a depth indented directory listing
    which                    # Shows the full path of (shell) commands
    file                     # Program that shows the type of files
    jq                       # Lightweight and flexible command-line JSON processor
    yq                       # Command-line YAML/XML/TOML processor - jq wrapper for YAML, XML, TOML documents
    man-db                   # Implementation of the standard Unix documentation system accessed using the man command
    udiskie
    udisks2
    libmtp
    android-tools
    # jmtpfs
    ntfs3g
    exfatprogs
    go-mtpfs
    glib
    qdl
    lm_sensors
    lact
    vulkan-tools
    mesa-demos
    payload_dumper
  ];
}

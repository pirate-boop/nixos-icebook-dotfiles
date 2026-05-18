{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # ── CLI ───────────────────────────
    #nano                    # Small, user-friendly console text editor
    # vim                    # Most popular clone of the VI editor
    # micro                  # Modern and intuitive terminal-based text editor
    neovim                   # Vim text editor fork focused on extensibility and agility
    helix                    # Post-modern modal text editor
    # ── (GUI) ───────────────────────────
    vscodium                 # Open source source code editor developed by Microslop for Windows, Linux (VS Code without Microslop
    zed-editor               # High-performance, multiplayer code editor from the creators of Atom and Tree-sitter
    # kdePackages.kate       # Advanced text editor
  ];
}

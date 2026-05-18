{ ... }:
let
  textEditor = "zed.desktop";
in {
  xdg.mimeApps.defaultApplications = {
    "text/plain"                = textEditor;
    "text/markdown"             = textEditor;
    "text/x-python"             = textEditor;
    "text/x-shellscript"        = textEditor;
    "text/x-sh"                 = textEditor;
    "text/x-csrc"               = textEditor;
    "text/x-chdr"               = textEditor;
    "text/x-makefile"           = textEditor;
    "text/x-nix"                = textEditor;
    "text/x-lua"                = textEditor;
    "text/x-rust"               = textEditor;
    "text/css"                  = textEditor;
    "text/javascript"           = textEditor;
    "text/typescript"           = textEditor;
    "application/json"          = textEditor;
    "application/xml"           = textEditor;
    "application/toml"          = textEditor;
    "application/x-yaml"        = textEditor;
    "application/x-shellscript" = textEditor;
  };
}


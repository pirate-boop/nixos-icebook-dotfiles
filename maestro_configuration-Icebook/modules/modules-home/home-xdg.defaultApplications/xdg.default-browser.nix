{ ... }:
let
  browser = "zen.desktop";
in {
  xdg.mimeApps.defaultApplications = {
    "text/html"               = browser;
    "x-scheme-handler/http"   = browser;
    "x-scheme-handler/https"  = browser;
    "x-scheme-handler/ftp"    = browser;
    "application/xhtml+xml"   = browser;
  };
}


{ ... }:
let
  emailClient = "thunderbird.desktop";
in {
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/mailto" = emailClient;
    "message/rfc822"          = emailClient;
  };
}

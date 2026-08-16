{ ... }:
let
  office = "libreoffice-startcenter.desktop";
in {
  xdg.mimeApps.defaultApplications = {
    "application/pdf"                    = office;
    "application/msword"                 = office;
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = office;
    "application/vnd.ms-excel"           = office;
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = office;
    "application/vnd.ms-powerpoint"      = office;
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" = office;
    "application/vnd.oasis.opendocument.text" = office;
    "application/vnd.oasis.opendocument.spreadsheet" = office;
    "application/vnd.oasis.opendocument.presentation" = office;
  };
}

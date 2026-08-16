{ inputs, pkgs, lib, ... }:
let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  extensions = [
    (extension "ublock-origin"               "uBlock0@raymondhill.net")
    (extension "tampermonkey"                "firefox@tampermonkey.net")
    (extension "bitwarden-password-manager"  "{446900e4-71c2-419f-a6a7-df9c091e268b}")
    (extension "sponsorblock"                "sponsorBlocker@ajay.app")
    (extension "return-youtube-dislikes"     "{762f9885-5a13-4abd-9c77-433dcd38b8fd}")
  ];

  prefs = {
    "extensions.autoDisableScopes" = 0;
    "extensions.pocket.enabled"    = false;
    "browser.tabs.inTitlebar"      = 0;
  };

in {
  environment.systemPackages = [
    (pkgs.wrapFirefox
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta-unwrapped
      {
        extraPrefs = lib.concatLines (
          lib.mapAttrsToList (
            name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
          ) prefs
        );

        extraPolicies = {
          DisableTelemetry = true;
          ExtensionSettings = builtins.listToAttrs extensions;

          SearchEngines = {
            Default = "ddg";
            Add = [
              {
                Name = "nixpkgs";
                URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@np";
              }
              {
                Name = "NixOS options";
                URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@no";
              }
              {
                Name = "noogle";
                URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                IconURL = "https://noogle.dev/favicon.ico";
                Alias = "@ng";
              }
              {
                Name = "YouTube";
                URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
                Alias = "@yt";
              }
              {
                Name = "GitHub";
                URLTemplate = "https://github.com/search?q={searchTerms}";
                Alias = "@gh";
              }
              {
                Name = "NixOS Wiki";
                URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@nw";
              }
            ];
          };
        };
      }
    )
  ];
}

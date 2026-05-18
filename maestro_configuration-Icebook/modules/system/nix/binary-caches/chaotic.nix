{ nix.settings = {
  substituters      = [ "https://nyx.chaotic.cx" "https://chaotic-nyx.cachix.org" ];
  trusted-public-keys = [
    "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agF+kAdsR4UkfKKvv9Yg="
    "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agF+kAdsR4UkfKKvv9Yg="
  ];
}; }

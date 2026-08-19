{
  pkgs,
  lib,
  ...
}: {
  # Route hardware video decode/render through the AMD iGPU instead of NVIDIA.
  # NVIDIA's VA-API support in Chromium/QtWebEngine has a known bug that causes
  # exactly the stuck-buffering / flickering behavior you're seeing on video.
  # AMD's open-source (Mesa) VA-API driver is far more reliable for this.
  home.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
  };

  programs.qutebrowser = {
    enable = true;
    settings = {
      colors.webpage.darkmode.enabled = true;
      fonts.default_family = lib.mkForce "JetBrains Mono";
      fonts.default_size = lib.mkForce "11pt";
      tabs.position = "top";
      scrolling.smooth = true;
      completion.shrink = true;

      # GPU / video decode tuning
      qt.args = [
        "disable-logging"
        "ignore-gpu-blocklist"
        "enable-gpu-rasterization"
        "enable-zero-copy"
        "enable-native-gpu-memory-buffers"
        "enable-oop-rasterization"
        # VA-API hardware video decode, routed via AMD (see LIBVA_DRIVER_NAME above)
        "enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoDecoder,VaapiIgnoreDriverChecks"
      ];

      content.blocking.enabled = true;
      content.blocking.method = "both";
      content.blocking.adblock.lists = [
        "https://easylist.to/easylist/easylist.txt"
        "https://easylist.to/easylist/easyprivacy.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt"
        # YouTube-specific ad-serving domains
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2020.txt"
        "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/BaseFilter/sections/adservers.txt"
      ];
    };

    greasemonkey = [
      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/1d1be041a65c251692ee082eda64d2637edf6444/youtube_sponsorblock.js";
        sha256 = "sha256-e3QgDPa3AOpPyzwvVjPQyEsSUC9goisjBUDMxLwg8ZE=";
      })
    ];

    extraConfig = ''
      config.load_autoconfig(False)
    '';
  };
}

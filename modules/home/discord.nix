{pkgs, ...}: let
  vencordTheme = ''
    /**
     * @name Winter Night Rice
     * @description Soft snowy blues and silver-white accents, inspired by a starlit winter sky
     */
    @import url('https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css');

    :root {
      /* Accent Colors */
      --accent-hue: 210 !important;
      --accent-saturation: 55% !important;
      --accent-lightness: 72% !important;

      --brand-experiment: #8fb4e3 !important;
      --brand-experiment-hover: #a9c6ec !important;
      --brand-experiment-active: #6f9bd6 !important;
      --brand-experiment-500: #8fb4e3 !important;
      --brand-experiment-600: #a9c6ec !important;

      /* Dark Background Palette - deep night sky */
      --background-primary: #0a0d16 !important;
      --background-secondary: #0e1220 !important;
      --background-secondary-alt: #121628 !important;
      --background-tertiary: #07090f !important;
      --background-accent: rgba(143, 180, 227, 0.15) !important;
      --background-floating: #10131f !important;

      /* Text & Highlights */
      --text-normal: #e9eef7 !important;
      --text-muted: #8a92ab !important;
      --text-link: #a9c6ec !important;
      --text-link-low-saturation: #c3d6f0 !important;
      --text-positive: #7fd8a3 !important;
      --text-warning: #e3cf8f !important;
      --text-danger: #e38f9a !important;
      --text-brand: #8fb4e3 !important;

      /* Interactive States */
      --interactive-normal: #e9eef7 !important;
      --interactive-hover: #ffffff !important;
      --interactive-active: #8fb4e3 !important;
      --interactive-muted: #4c5670 !important;

      /* Custom Selection & Scrollbar */
      --scrollbar-thin-thumb: #8fb4e3 !important;
      --scrollbar-auto-thumb: #8fb4e3 !important;
      --scrollbar-auto-track: #0a0d16 !important;
    }

    /* Frosted Glow Effects */
    .theme-dark .container-2cd30y,
    .theme-dark .members-3W93L3,
    .theme-dark .sidebar-1tnWFu {
      background-color: var(--background-secondary) !important;
    }

    .selected-rO2M3e,
    .item-2LI83y[aria-selected="true"] {
      background: linear-gradient(135deg, rgba(143, 180, 227, 0.25) 0%, rgba(30, 40, 70, 0.4) 100%) !important;
      border: 1px solid #8fb4e3 !important;
      box-shadow: 0 0 12px rgba(143, 180, 227, 0.3) !important;
    }
  '';
in {
  home.packages = with pkgs; [
    vesktop
    discord
  ];

  programs.discord = {
    enable = true;
    package = pkgs.discord;
    settings = {
      SKIP_HOST_UPDATE = true;
    };
  };

  # Vesktop / Vencord custom CSS theme installation
  home.file = {
    ".config/vesktop/themes/winter-night.css".text = vencordTheme;
    ".config/Vencord/themes/winter-night.css".text = vencordTheme;
    ".var/app/dev.vencord.Vesktop/config/vesktop/themes/winter-night.css".text = vencordTheme;

    ".config/vesktop/settings/settings.json".text = builtins.toJSON {
      enabledThemes = ["winter-night.css"];
      useQuickCss = true;
      themeAttributes = {
        winter-night = {
          enabled = true;
        };
      };
    };
  };
}

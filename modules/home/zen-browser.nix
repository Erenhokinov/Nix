{
  pkgs,
  inputs,
  ...
}: let
  # Prefer explicit package name if available; fall back to default
  zenPkg =
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser
    or inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;

  profilesIni = ''
    [Profile0]
    Name=default
    IsRelative=1
    Path=default
    Default=1

    [General]
    StartWithLastProfile=1
    Version=2
  '';

  chromeCss = ''
    @namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");

    /* ==========================================================================
       Zen Browser - Winter Night Theme & Zen Mods Edition
       ========================================================================== */

    :root,
    #main-window,
    #zen-appcontent {
      /* Zen Internal CSS Variables Override */
      --zen-primary-color: #8fb4e3 !important;
      --zen-colors-primary: #8fb4e3 !important;
      --zen-colors-secondary: #10131f !important;
      --zen-colors-tertiary: #0e1220 !important;
      --zen-colors-bg: #0a0d16 !important;
      --zen-colors-border: rgba(143, 180, 227, 0.3) !important;
      --zen-colors-input-bg: #121628 !important;
      --zen-main-browser-background: #0a0d16 !important;
      --zen-sidebar-background: #0e1220 !important;
      --zen-theme-accent: #8fb4e3 !important;

      /* Core Palette */
      --zen-bg-dark: #0a0d16 !important;
      --zen-bg-panel: #0e1220 !important;
      --zen-bg-card: #121628 !important;
      --zen-red-primary: #8fb4e3 !important;
      --zen-red-glow: rgba(143, 180, 227, 0.45) !important;
      --zen-red-subtle: rgba(143, 180, 227, 0.12) !important;
      --zen-red-border: rgba(143, 180, 227, 0.3) !important;
      --zen-text-main: #e9eef7 !important;
      --zen-text-muted: #8a92ab !important;

      /* Browser UI Overrides */
      --toolbar-bgcolor: var(--zen-bg-panel) !important;
      --lwt-accent-color: var(--zen-bg-dark) !important;
      --lwt-text-color: var(--zen-text-main) !important;
      --toolbarbutton-hover-background: rgba(143, 180, 227, 0.18) !important;
      --toolbarbutton-active-background: rgba(143, 180, 227, 0.3) !important;
      --toolbarbutton-border-radius: 10px !important;

      --urlbar-box-focus-bgcolor: #141a2c !important;
      --urlbar-focused-border-color: var(--zen-red-primary) !important;
      --tab-min-height: 34px !important;
    }

    /* Window & Main Containers */
    #main-window,
    #navigator-toolbox,
    #browser,
    #zen-appcontent,
    .zen-browser-overflow,
    body {
      background-color: var(--zen-bg-dark) !important;
    }

    /* Zen Mod: Winter Workspace & Sidebar */
    #sidebar-box,
    #sidebar-header,
    .zen-sidebar-pad,
    #zen-essential-sidebar,
    #zen-sidebar-web-panels {
      background-color: var(--zen-sidebar-background) !important;
      border-right: 1px solid var(--zen-red-border) !important;
    }

    /* Zen Workspaces Button & Active Workspace Indicator Mod */
    .zen-workspace-button,
    #zen-workspaces-button {
      border-radius: 12px !important;
      border: 1px solid rgba(143, 180, 227, 0.15) !important;
      transition: all 0.2s ease !important;
    }

    .zen-workspace-button:hover,
    #zen-workspaces-button:hover {
      background-color: rgba(143, 180, 227, 0.2) !important;
      border-color: var(--zen-red-primary) !important;
      box-shadow: 0 0 10px var(--zen-red-glow) !important;
    }

    #zen-current-workspace-indicator {
      background: linear-gradient(135deg, #8fb4e3, #4c6f9e) !important;
      box-shadow: 0 0 12px var(--zen-red-glow) !important;
    }

    /* Zen Mod: Floating Glass URL Bar */
    #urlbar-background {
      background-color: var(--zen-bg-card) !important;
      border: 1px solid var(--zen-red-border) !important;
      border-radius: 14px !important;
      transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1) !important;
    }

    #urlbar[focused="true"] > #urlbar-background {
      background-color: #161c30 !important;
      border-color: var(--zen-red-primary) !important;
      box-shadow: 0 0 18px var(--zen-red-glow), inset 0 0 10px rgba(143, 180, 227, 0.2) !important;
    }

    #urlbar-input {
      color: var(--zen-text-main) !important;
      font-weight: 500 !important;
    }

    .urlbar-icon,
    .toolbarbutton-icon {
      fill: var(--zen-text-main) !important;
      color: var(--zen-text-main) !important;
      transition: transform 0.15s ease, color 0.15s ease !important;
    }

    .urlbar-icon:hover,
    .toolbarbutton-icon:hover {
      filter: drop-shadow(0 0 6px var(--zen-red-primary)) !important;
      color: var(--zen-red-primary) !important;
    }

    /* Zen Mod: Glowing Vertical Tabs & Floating Cards */
    #TabsToolbar {
      background-color: var(--zen-bg-dark) !important;
    }

    .tabbrowser-tab {
      padding-inline: 4px !important;
    }

    .tab-background {
      border-radius: 12px !important;
      margin-block: 3px !important;
      background-color: rgba(143, 180, 227, 0.08) !important;
      border: 1px solid rgba(143, 180, 227, 0.15) !important;
      transition: all 0.2s ease-in-out !important;
    }

    .tabbrowser-tab:hover .tab-background {
      background-color: rgba(143, 180, 227, 0.18) !important;
      border-color: rgba(143, 180, 227, 0.35) !important;
      box-shadow: 0 0 12px rgba(143, 180, 227, 0.2) !important;
    }

    .tabbrowser-tab[selected="true"] .tab-background {
      background: linear-gradient(135deg, rgba(143, 180, 227, 0.32) 0%, rgba(40, 55, 90, 0.4) 100%) !important;
      border: 1px solid var(--zen-red-primary) !important;
      box-shadow: 0 0 16px var(--zen-red-glow) !important;
    }

    .tab-label {
      color: var(--zen-text-main) !important;
      font-weight: 500 !important;
    }

    .tabbrowser-tab[selected="true"] .tab-label {
      color: #ffffff !important;
      text-shadow: 0 0 8px var(--zen-red-glow) !important;
    }

    /* Zen Mod: Split View Divider */
    .zen-split-view-modifier {
      border-color: var(--zen-red-primary) !important;
      box-shadow: 0 0 8px var(--zen-red-glow) !important;
    }

    /* Context Menus & Popups - Dark Glassmorphism */
    menupopup,
    panel {
      --panel-background: var(--zen-bg-panel) !important;
      --panel-border-color: var(--zen-red-border) !important;
      --panel-color: var(--zen-text-main) !important;
      border-radius: 14px !important;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.85), 0 0 14px var(--zen-red-subtle) !important;
    }

    menuitem:hover,
    menu:hover {
      background-color: rgba(143, 180, 227, 0.25) !important;
      color: #ffffff !important;
      border-radius: 8px !important;
    }

    /* Scrollbars */
    * {
      scrollbar-width: thin !important;
      scrollbar-color: var(--zen-red-primary) var(--zen-bg-dark) !important;
    }
  '';

  contentCss = ''
    @-moz-document url-prefix(about:), url-prefix(chrome:), url-prefix(resource:) {
      :root {
        color-scheme: dark !important;
        accent-color: #8fb4e3 !important;
        --in-content-page-background: #0a0d16 !important;
        --in-content-page-color: #e9eef7 !important;
        --in-content-box-background: #0e1220 !important;
        --in-content-box-info-background: #121628 !important;
        --in-content-border-color: rgba(143, 180, 227, 0.3) !important;
        --in-content-primary-button-background: #8fb4e3 !important;
        --in-content-primary-button-text-color: #0a0d16 !important;
        --in-content-primary-button-background-hover: #a9c6ec !important;
      }

      body, page {
        background-color: #0a0d16 !important;
        color: #e9eef7 !important;
      }

      a {
        color: #a9c6ec !important;
        text-decoration: none !important;
      }

      a:hover {
        color: #c3d6f0 !important;
        text-shadow: 0 0 8px rgba(143, 180, 227, 0.5) !important;
      }

      ::selection {
        background-color: rgba(143, 180, 227, 0.4) !important;
        color: #ffffff !important;
      }
    }
  '';

  userJs = ''
    // Enable custom stylesheets and legacy customizations in Gecko / Zen Browser
    user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
    user_pref("svg.context-properties.content.enabled", true);
    user_pref("layout.css.has-selector.enabled", true);

    // Zen Theme & Accent Preferences
    user_pref("zen.theme.accent-color", "#8fb4e3");
    user_pref("zen.theme.accent-color.custom", "#8fb4e3");
    user_pref("zen.theme.mode", "dark");
    user_pref("zen.theme.allow-theme-colors", true);
    user_pref("zen.theme.use-system-accent", false);

    // Performance & Low-Memory Optimization
    user_pref("browser.tabs.unloadOnLowMemory", true);
    user_pref("browser.tabs.warnOnClose", false);
    user_pref("browser.tabs.maxOpenBeforeWarn", 20);
    user_pref("browser.sessionstore.interval", 60000);
    user_pref("browser.sessionstore.max_tabs_undo", 10);
    user_pref("browser.cache.memory.capacity", 32768);
    user_pref("dom.ipc.processCount", 1);
    user_pref("dom.ipc.processCount.webIsolated", 1);
    user_pref("gfx.webrender.all", true);
    user_pref("media.memory_cache_max_size", 262144);
    user_pref("network.http.max-connections", 48);
    user_pref("network.http.max-connections-per-server", 16);
    user_pref("privacy.clearOnShutdown.history", false);
    user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
  '';
in {
  # Install Zen Browser for the user
  home.packages = [zenPkg];

  home.file = {
    # Primary Zen Profile (~/.zen/)
    ".zen/profiles.ini".text = profilesIni;
    ".zen/default/chrome/userChrome.css".text = chromeCss;
    ".zen/default/chrome/userContent.css".text = contentCss;
    ".zen/default/user.js".text = userJs;

    ".zen/default-release/chrome/userChrome.css".text = chromeCss;
    ".zen/default-release/chrome/userContent.css".text = contentCss;
    ".zen/default-release/user.js".text = userJs;

    # Fallback Zen Profile (~/.mozilla/zen/)
    ".mozilla/zen/profiles.ini".text = profilesIni;
    ".mozilla/zen/default/chrome/userChrome.css".text = chromeCss;
    ".mozilla/zen/default/chrome/userContent.css".text = contentCss;
    ".mozilla/zen/default/user.js".text = userJs;

    ".mozilla/zen/default-release/chrome/userChrome.css".text = chromeCss;
    ".mozilla/zen/default-release/chrome/userContent.css".text = contentCss;
    ".mozilla/zen/default-release/user.js".text = userJs;

    # Generic Config Fallback
    ".config/zen-browser/chrome/userChrome.css".text = chromeCss;
    ".config/zen-browser/chrome/userContent.css".text = contentCss;
    ".config/zen-browser/user.js".text = userJs;
  };
}

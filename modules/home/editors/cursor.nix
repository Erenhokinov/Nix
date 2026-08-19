{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.lib) attrByPath;

  # Shared palette with qutebrowser — clean white, soft surfaces, vivid blue
  palette = {
    base = "#ffffff";
    surface = "#f4f6fb";
    surfaceAlt = "#e8edf5";
    border = "#d8dee9";
    fg = "#1a2332";
    fgMuted = "#5c6b82";
    accent = "#2563eb";
    accentSoft = "#dbeafe";
    accentGlow = "#3b82f6";
    success = "#059669";
    warning = "#d97706";
    error = "#dc2626";
  };

  hyprlangVer = "0.0.3";
  hyprlsVer = "0.1.2";
  neroHyprlandVer = "0.0.2";

  extOrMarketplace = {
    publisher,
    name,
    version ? null,
    sha256 ? null,
  }: let
    fromOpenVSX = attrByPath [publisher name] null pkgs.vscode-extensions;
  in
    if fromOpenVSX != null
    then [fromOpenVSX]
    else if version == null
    then []
    else
      pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          inherit name publisher version;
          sha256 =
            if sha256 == null
            then pkgs.lib.fakeSha256
            else sha256;
        }
      ];

  hyprlangExts = extOrMarketplace {
    publisher = "fireblast";
    name = "hyprlang-vscode";
    version = hyprlangVer;
    sha256 = "sha256-iMCyomgMGGUXaVqq1l7bgyvFgZa/W/eWHaqkA5RmExE=";
  };
  hyprlsExts = extOrMarketplace {
    publisher = "ewen-lbh";
    name = "vscode-hyprls";
    version = hyprlsVer;
    sha256 = "sha256-pTg8ZyfhZj31Rv8gxhPbQ+CYzb5MXYdaI46JQHPU9ng=";
  };
  neroHyprlandExts = extOrMarketplace {
    publisher = "amarcos1337";
    name = "nero-hyprland";
    version = neroHyprlandVer;
    sha256 = "sha256-3RiSYmJK/xODCvUi9c2xtvEIWSBABVHk6QYCAFoqsa8=";
  };

  workbenchColors = {
    "editor.background" = palette.base;
    "editor.foreground" = palette.fg;
    "editorLineNumber.foreground" = palette.fgMuted;
    "editorLineNumber.activeForeground" = palette.accent;
    "editor.selectionBackground" = palette.accentSoft;
    "editor.inactiveSelectionBackground" = palette.surfaceAlt;
    "editor.lineHighlightBackground" = palette.surface;
    "editorCursor.foreground" = palette.accent;
    "editorWhitespace.foreground" = palette.border;
    "editorIndentGuide.background1" = palette.surfaceAlt;
    "editorIndentGuide.activeBackground1" = palette.border;
    "editorBracketMatch.background" = palette.accentSoft;
    "editorBracketMatch.border" = palette.accent;
    "editorGutter.background" = palette.base;
    "editorWidget.background" = palette.base;
    "editorWidget.border" = palette.border;
    "editorSuggestWidget.background" = palette.base;
    "editorSuggestWidget.border" = palette.border;
    "editorSuggestWidget.selectedBackground" = palette.accentSoft;
    "editorHoverWidget.background" = palette.base;
    "editorHoverWidget.border" = palette.border;

    "sideBar.background" = palette.surface;
    "sideBar.foreground" = palette.fg;
    "sideBar.border" = palette.border;
    "sideBarTitle.foreground" = palette.fg;
    "sideBarSectionHeader.background" = palette.surfaceAlt;
    "sideBarSectionHeader.foreground" = palette.fgMuted;

    "activityBar.background" = palette.base;
    "activityBar.foreground" = palette.accent;
    "activityBar.inactiveForeground" = palette.fgMuted;
    "activityBar.border" = palette.border;
    "activityBarBadge.background" = palette.accent;
    "activityBarBadge.foreground" = palette.base;

    "titleBar.activeBackground" = palette.base;
    "titleBar.activeForeground" = palette.fg;
    "titleBar.inactiveBackground" = palette.surface;
    "titleBar.inactiveForeground" = palette.fgMuted;
    "titleBar.border" = palette.border;

    "statusBar.background" = palette.base;
    "statusBar.foreground" = palette.fg;
    "statusBar.border" = palette.border;
    "statusBar.debuggingBackground" = palette.accentSoft;
    "statusBar.debuggingForeground" = palette.accent;
    "statusBar.noFolderBackground" = palette.surface;
    "statusBarItem.hoverBackground" = palette.surfaceAlt;
    "statusBarItem.remoteBackground" = palette.accent;
    "statusBarItem.remoteForeground" = palette.base;

    "tab.activeBackground" = palette.base;
    "tab.inactiveBackground" = palette.surface;
    "tab.activeForeground" = palette.fg;
    "tab.inactiveForeground" = palette.fgMuted;
    "tab.activeBorderTop" = palette.accent;
    "tab.border" = palette.border;
    "editorGroupHeader.tabsBackground" = palette.surface;
    "editorGroupHeader.tabsBorder" = palette.border;
    "editorGroup.border" = palette.border;

    "panel.background" = palette.base;
    "panel.border" = palette.border;
    "panelTitle.activeForeground" = palette.accent;
    "panelTitle.inactiveForeground" = palette.fgMuted;

    "terminal.background" = palette.base;
    "terminal.foreground" = palette.fg;
    "terminalCursor.foreground" = palette.accent;
    "terminal.border" = palette.border;

    "focusBorder" = palette.accent;
    "selection.background" = palette.accentSoft;
    "button.background" = palette.accent;
    "button.foreground" = palette.base;
    "button.hoverBackground" = palette.accentGlow;
    "input.background" = palette.base;
    "input.foreground" = palette.fg;
    "input.border" = palette.border;
    "input.placeholderForeground" = palette.fgMuted;
    "dropdown.background" = palette.base;
    "dropdown.border" = palette.border;
    "dropdown.foreground" = palette.fg;

    "list.activeSelectionBackground" = palette.accentSoft;
    "list.activeSelectionForeground" = palette.fg;
    "list.hoverBackground" = palette.surfaceAlt;
    "list.inactiveSelectionBackground" = palette.surfaceAlt;
    "list.focusOutline" = palette.accent;

    "scrollbarSlider.background" = "${palette.border}88";
    "scrollbarSlider.hoverBackground" = "${palette.fgMuted}aa";
    "scrollbarSlider.activeBackground" = palette.accent;

    "badge.background" = palette.accent;
    "badge.foreground" = palette.base;
    "progressBar.background" = palette.accent;

    "breadcrumb.background" = palette.base;
    "breadcrumb.foreground" = palette.fgMuted;
    "breadcrumb.focusForeground" = palette.accent;
    "breadcrumb.activeSelectionForeground" = palette.fg;

    "gitDecoration.modifiedResourceForeground" = palette.warning;
    "gitDecoration.deletedResourceForeground" = palette.error;
    "gitDecoration.untrackedResourceForeground" = palette.success;
    "gitDecoration.ignoredResourceForeground" = palette.fgMuted;

    "minimap.background" = palette.surface;
    "minimap.selectionHighlight" = palette.accentSoft;
    "minimapSlider.background" = "${palette.border}66";
    "minimapSlider.hoverBackground" = "${palette.fgMuted}88";
  };
in {
  programs.cursor = {
    enable = true;
    package = pkgs.code-cursor;

    argvSettings = {
      enable-crash-reporter = false;
      disable-hardware-acceleration = false;
    };

    profiles.default = {
      extensions =
        (with pkgs.vscode-extensions; [
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
          bbenoist.nix
          kamadorueda.alejandra
          jeff-hykin.better-nix-syntax
          ms-python.python
          charliermarsh.ruff
          ms-vscode.cpptools-extension-pack
          tamasfe.even-better-toml
          zainchen.json
          shd101wyy.markdown-preview-enhanced
          eamodio.gitlens
          usernamehw.errorlens
          pkief.material-icon-theme
          formulahendry.code-runner
        ])
        ++ hyprlangExts
        ++ hyprlsExts
        ++ neroHyprlandExts;

      userSettings = lib.mkForce {
        # ── Theme (qutebrowser light style) ─────────────────────────────
        "workbench.colorTheme" = "Catppuccin Latte";
        "workbench.iconTheme" = "catppuccin-latte";
        "workbench.colorCustomizations" = workbenchColors;
        "catppuccin.accentColor" = "blue";
        "catppuccin.workbenchTransparency" = false;
        "window.autoDetectColorScheme" = false;
        "workbench.preferredLightColorTheme" = "Catppuccin Latte";
        "workbench.preferredDarkColorTheme" = "Catppuccin Latte";

        # ── Flat, clean layout ───────────────────────────────────────────
        "window.titleBarStyle" = "custom";
        "window.menuBarVisibility" = "compact";
        "window.commandCenter" = true;
        "workbench.activityBar.location" = "top";
        "workbench.editor.showTabs" = "multiple";
        "workbench.editor.tabSizing" = "shrink";
        "workbench.editor.highlightModifiedTabs" = true;
        "workbench.editor.enablePreview" = false;
        "workbench.startupEditor" = "none";
        "workbench.tree.indent" = 16;
        "workbench.tree.renderIndentGuides" = "always";
        "workbench.sideBar.location" = "left";
        "workbench.statusBar.visible" = true;
        "breadcrumbs.enabled" = true;

        # ── Typography & smooth editor feel ──────────────────────────────
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 13;
        "editor.lineHeight" = 1.65;
        "editor.fontWeight" = "400";
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.cursorStyle" = "line";
        "editor.cursorWidth" = 2;
        "editor.smoothScrolling" = true;
        "editor.renderLineHighlight" = "gutter";
        "editor.renderWhitespace" = "selection";
        "editor.guides.indentation" = true;
        "editor.guides.bracketPairs" = "active";
        "editor.bracketPairColorization.enabled" = true;
        "editor.stickyScroll.enabled" = true;
        "editor.minimap.enabled" = false;
        "editor.occurrencesHighlight" = "singleFile";
        "editor.linkedEditing" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.suggest.preview" = true;
        "editor.suggestSelection" = "first";
        "editor.quickSuggestions" = {
          other = true;
          comments = false;
          strings = true;
        };
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.detectIndentation" = true;
        "editor.formatOnSave" = true;
        "editor.codeActionsOnSave" = {
          "source.fixAll" = "explicit";
          "source.organizeImports" = "explicit";
        };
        "editor.padding.top" = 8;
        "editor.padding.bottom" = 8;

        # ── Smooth scrolling everywhere ──────────────────────────────────
        "workbench.list.smoothScrolling" = true;
        "terminal.integrated.smoothScrolling" = true;
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
        "terminal.integrated.fontSize" = 12;
        "terminal.integrated.cursorBlinking" = true;
        "terminal.integrated.cursorStyle" = "line";

        # ── Files & workflow ─────────────────────────────────────────────
        "files.autoSave" = "onFocusChange";
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;
        "files.simpleDialog.enable" = true;
        "explorer.compactFolders" = false;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "search.showLineNumbers" = true;
        "search.smartCase" = true;

        # ── Git ──────────────────────────────────────────────────────────
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "scm.defaultViewMode" = "tree";

        # ── Nix ──────────────────────────────────────────────────────────
        "[nix]" = {
          "editor.defaultFormatter" = "kamadorueda.alejandra";
          "editor.tabSize" = 2;
        };

        # ── Python ───────────────────────────────────────────────────────
        "[python]" = {
          "editor.defaultFormatter" = "charliermarsh.ruff";
          "editor.tabSize" = 4;
        };

        # ── JSON / TOML / Markdown ───────────────────────────────────────
        "[json]" = {
          "editor.defaultFormatter" = "vscode.json-language-features";
        };
        "[jsonc]" = {
          "editor.defaultFormatter" = "vscode.json-language-features";
        };
        "[toml]" = {
          "editor.defaultFormatter" = "tamasfe.even-better-toml";
        };
        "[markdown]" = {
          "editor.wordWrap" = "on";
          "editor.quickSuggestions" = {
            other = true;
            comments = true;
            strings = true;
          };
        };

        # ── Cursor AI tweaks ─────────────────────────────────────────────
        "cursor.cpp.disabledLanguages" = [];
        "cursor.general.enableShadowWorkspace" = true;
        "update.mode" = "manual";
        "extensions.autoCheckUpdates" = false;
      };

      keybindings = [
        {
          key = "ctrl+shift+f";
          command = "workbench.action.findInFiles";
        }
        {
          key = "ctrl+p";
          command = "workbench.action.quickOpen";
        }
        {
          key = "ctrl+shift+p";
          command = "workbench.action.showCommands";
        }
        {
          key = "ctrl+b";
          command = "workbench.action.toggleSidebarVisibility";
        }
        {
          key = "ctrl+j";
          command = "workbench.action.togglePanel";
        }
        {
          key = "ctrl+\\";
          command = "workbench.action.splitEditor";
        }
        {
          key = "ctrl+w";
          command = "workbench.action.closeActiveEditor";
        }
        {
          key = "ctrl+shift+k";
          command = "editor.action.deleteLines";
          when = "editorTextFocus && !editorReadonly";
        }
        {
          key = "alt+up";
          command = "editor.action.moveLinesUpAction";
          when = "editorTextFocus && !editorReadonly";
        }
        {
          key = "alt+down";
          command = "editor.action.moveLinesDownAction";
          when = "editorTextFocus && !editorReadonly";
        }
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}

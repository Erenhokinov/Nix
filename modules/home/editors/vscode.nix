{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.lib) attrByPath;

  hyprlangVer = "0.0.3";
  hyprlsVer = "0.1.2";
  neroHyprlandVer = "0.0.2";
  codeRunnerVer = "0.12.4";

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
  codeRunnerExts = extOrMarketplace {
    publisher = "formulahendry";
    name = "code-runner";
    version = codeRunnerVer;
    sha256 = pkgs.lib.fakeSha256;
  };
  synthwaveExts = extOrMarketplace {
  publisher = "RobbOwen";
  name = "synthwave-vscode";
  version = "0.1.20";
  sha256 = "sha256-J8igs+SQn967OK0PLNZtV9IOJRqwd+q9vmZ+p9eKSoU=";
};
  };
in {
  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        extensions =
          (with pkgs.vscode-extensions; [
            bbenoist.nix
            kamadorueda.alejandra
            jeff-hykin.better-nix-syntax
            ms-vscode.cpptools-extension-pack
            vscodevim.vim
            mads-hartmann.bash-ide-vscode
            tamasfe.even-better-toml
            zainchen.json
            shd101wyy.markdown-preview-enhanced

            # --- visual/quality-of-life additions ---
            usernamehw.errorlens
            oderwat.indent-rainbow
            gruntfuggly.todo-tree
            aaron-bond.better-comments
            eamodio.gitlens
            editorconfig.editorconfig
            streetsidesoftware.code-spell-checker
            naumovs.color-highlight
            formulahendry.auto-rename-tag
            pkief.material-icon-theme # matches SynthWave's neon vibe far better than default icons
          ])
          ++ hyprlangExts
          ++ hyprlsExts
          ++ neroHyprlandExts
          ++ codeRunnerExts
          ++ synthwaveExts;

        userSettings = lib.mkForce {
          "workbench.colorTheme" = "SynthWave '84";
          "workbench.iconTheme" = "material-icon-theme";
          "window.autoDetectColorScheme" = false;

          "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace'";
          "editor.fontLigatures" = true;
          "editor.fontSize" = 14;
          "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono'";
          "terminal.integrated.fontSize" = 13;

          "editor.cursorBlinking" = "phase";
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.smoothScrolling" = true;
          "workbench.list.smoothScrolling" = true;
          "terminal.integrated.smoothScrolling" = true;

          "editor.bracketPairColorization.enabled" = true;
          "editor.guides.bracketPairs" = true;
          "editor.guides.indentation" = true;
          "editor.stickyScroll.enabled" = true;
          "editor.minimap.enabled" = true;
          "editor.minimap.renderCharacters" = false;
          "editor.minimap.maxColumn" = 80;
          "breadcrumbs.enabled" = true;

          "workbench.layoutControl.enabled" = false;
          "workbench.activityBar.location" = "top";
          "window.titleBarStyle" = "custom";
          "workbench.tree.indent" = 16;
        };
      };
    };
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["openssl-1.1.1w"];
}

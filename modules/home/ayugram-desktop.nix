{
  pkgs,
  inputs,
  ...
}: let
  ayuCrimsonColors = ''
    // Crimson Dark Theme Palette for AyuGram / Telegram
    windowBg: #090103;
    windowFg: #fce8eb;
    windowBgOver: #170408;
    windowBgRipple: #26060e;
    windowFgActive: #ffffff;

    activeButtonBg: #ff2a4b;
    activeButtonBgOver: #e61c3c;
    activeButtonFg: #ffffff;

    dialogsBg: #0f0306;
    dialogsBgOver: #1a050b;
    dialogsBgActive: #2a0811;
    dialogsNameFg: #fce8eb;
    dialogsChatIconFg: #ff2a4b;
    dialogsDateFg: #b88a93;
    dialogsTextFg: #b88a93;

    msgInBg: #140407;
    msgInFg: #fce8eb;
    msgOutBg: #2b070f;
    msgOutFg: #ffffff;
    msgInDateFg: #b88a93;
    msgOutDateFg: #e6a3af;
    msgInServiceFg: #ff5270;

    historyTextInFg: #fce8eb;
    historyTextOutFg: #ffffff;
    historyLinkInFg: #ff5270;
    historyLinkOutFg: #ff758c;

    sideBarBg: #090103;
    sideBarTextFg: #b88a93;
    sideBarIconFg: #ff2a4b;
  '';
in {
  home.packages = with pkgs; [
    inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop
  ];

  # Install Telegram/AyuGram custom color palette file
  home.file = {
    ".local/share/AyuGramDesktop/tdata/crimson.tdesktop-theme-colors".text = ayuCrimsonColors;
    ".local/share/TelegramDesktop/tdata/crimson.tdesktop-theme-colors".text = ayuCrimsonColors;
  };
}

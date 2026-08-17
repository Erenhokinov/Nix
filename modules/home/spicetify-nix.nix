{
  pkgs,
  inputs,
  lib,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
    ];
    theme = lib.mkForce spicePkgs.themes.catppuccin;
    colorScheme = lib.mkForce "mocha";
  };
}

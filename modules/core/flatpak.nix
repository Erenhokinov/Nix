{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    configPackages = [pkgs.hyprland];
  };
  services = {
    flatpak = {
      enable = true;

      # Configures Flathub as the source repository for your packages
      remotes = [
        {
          name = "flathub";
          location = "https://flathub.org";
        }
      ];

      # List the Flatpak applications you want to install
      packages = [
        #   "org.vinegarhq.Sober" # Roblox client for Linux
        "com.github.tchx84.Flatseal" #Manage flatpak permissions - should always have this
        #"com.rtosta.zapzap"              # WhatsApp client
        #"io.github.flattool.Warehouse"   # Manage flatpaks, clean data, remove flatpaks and deps
        #"it.mijorus.gearlever" # Manage and support AppImages
        #"io.github.freedoom.Phase1"      #  Classic Doom FPS 1
        #"io.github.freedoom.Phase2"      #  Classic Doom FPS 2
        #"io.github.dvlv.boxbuddyrs"      #  Manage distroboxes
        "de.schmidhuberj.tubefeeder" #watch YT videos
      ];

      # Optional: Automatically update Flatpaks when you run nixos-rebuild switch
      update.onActivation = true;
    };
  };
}

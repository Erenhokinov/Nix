{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    #enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-vkcapture
      obs-source-clone
      (obs-move-transition.overrideAttrs (old: {
        env = (old.env or { }) // {
          NIX_CFLAGS_COMPILE = toString [
            (old.env.NIX_CFLAGS_COMPILE or "")
            "-Wno-error=deprecated-declarations"
          ];
        };
      }))
      obs-composite-blur
      obs-backgroundremoval
    ];
  };
}

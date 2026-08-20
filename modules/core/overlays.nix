{inputs, ...}: {
  nixpkgs.overlays = [
    inputs.prismlauncher-cracked.overlays.default

    (final: prev: {
      prismlauncher-unwrapped =
        (prev.prismlauncher-unwrapped.override {
          extra-cmake-modules = final.kdePackages.extra-cmake-modules;
        }).overrideAttrs (old: {
          nativeBuildInputs = old.nativeBuildInputs ++ [final.pkg-config];
        });
    })

    (_final: prev: {
      xfce =
        prev.xfce
        // {
          tumbler = prev.xfce.tumbler.overrideAttrs (old: {
            buildInputs = prev.lib.remove prev.libgepub old.buildInputs;
          });
        };
    })
  ];
}

{
  pkgs,
  config,
  ...
}: let
  customEdid = pkgs.runCommandNoCC "custom-100hz-edid" {} ''
    mkdir -p $out/lib/firmware/edid
    cp ${../../100hz.bin} $out/lib/firmware/edid/100hz.bin
  '';
in {
  hardware.firmware = [customEdid];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = ["v4l2loopback" "usbhid"];
    extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
    kernel.sysctl = {"vm.max_map_count" = 2147483642;};
    extraModprobeConfig = "options usbhid mousepoll=1";
    kernelParams = [
      "drm.edid_firmware=eDP-1:edid/100hz.bin"
      "nowatchdog"
    ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    plymouth.enable = false;
  };
}

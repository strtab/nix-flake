{ config, ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        editor = false;
      };
      efi.efiSysMountPoint = "/boot";
      timeout = 1;
    };
    kernelParams = [
      "rw" # read write
      "mitigations=off" # disable cpu security (better performance)
      "video=HDMI-A-1"
      "video=LVDS-1:d" # disable monitor
    ];
  };
}

{ ... }:
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
      "rw"
      "mitigations=off"
      "video=HDMI-A-1"
      "video=LVDS-1:d"
    ];
  };
}

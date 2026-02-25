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
    extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
    kernelModules = [
      "i2c_dev" # brightness control
      "ddcci_backlight"
    ];
    kernelParams = [
      "rw" # read write
      "mitigations=off" # disable cpu security (more productive)
      "video=HDMI-A-1"
      "video=LVDS-1:d" # disable monitor
    ];
  };
  # https://www.ddcutil.com/i2c_permissions/
  services.udev.extraRules = ''
    SUBSYSTEM=="i2c-dev", KERNEL=="i2c-[0-9]*", ATTRS{class}=="0x030000", TAG+="uaccess"
    SUBSYSTEM=="dri", KERNEL=="card[0-9]*", TAG+="uaccess"
  '';
}

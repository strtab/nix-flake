{
  boot = {
    plymouth = {
      enable = true;
    };
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        editor = false;
      };
      efi.efiSysMountPoint = "/boot";
      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      timeout = 0;
    };
    kernelParams = [
      "rw" # read write
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"

      "mitigations=off" # disable cpu security (better performance)

      "video=HDMI-A-1"
      "video=LVDS-1:d" # disable monitor
    ];
  };
}

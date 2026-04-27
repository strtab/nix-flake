{ config, ... }:
{
  imports = [
    # Init
    ./hardware-configuration.nix
    ./hardware # Hardware imports there
    ./variables.nix # Common variables
    ./network # Network configuration
    ./boot # Bootloader

    # System
    ./../../mods/system/nix.nix
    ./../../mods/system/users.nix
    ./../../mods/system/hyprland.nix
    ./../../mods/system/home-manager.nix
    ./../../mods/system/fonts.nix
    ./../../mods/system/pkgs.nix
    ./../../mods/system/utils.nix

    # Services
    ./../../mods/services/naiveproxy.nix
    ./../../mods/services/v2raya.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  programs = {
    nano.enable = false;
    steam.enable = true;
  };

  zramSwap.enable = false;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 20 * 1024;
    }
  ];

  console.font = "UniCyr_8x16";
  time.timeZone = "Europe/Moscow";
  system.stateVersion = "25.11";
}

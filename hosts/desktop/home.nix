{ config, ... }:
{
  imports = [
    ./variables.nix

    # System
    ../../home/system/illogical-impulce.nix
    ../../home/system/environments.nix
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}

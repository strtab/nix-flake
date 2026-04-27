{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ wireshark ];
  users.users."${config.var.username}".extraGroups = [ "wireshark" ];
  programs = {
    wireshark = {
      enable = true;
      dumpcap.enable = true;
      usbmon.enable = true;
    };
  };
}

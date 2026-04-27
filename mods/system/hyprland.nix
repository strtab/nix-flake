{
  config,
  pkgs,
  inputs,
  ...
}:
{
  xdg = {
    icons.fallbackCursorThemes = [ "Bibata-Modern-Classic" ];
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        kdePackages.xdg-desktop-portal-kde
      ];
    };
  };

  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    ];
  };

  services = {
    geoclue2.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "start-hyprland";
          user = config.var.username;
        };
        default_session = {
          command = "start-hyprland";
          user = config.var.username;
        };
      };
    };
  };

  programs = {
    dconf.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}

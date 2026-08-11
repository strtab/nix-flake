{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.aether.homeManagerModules.default ];

  # wayland.windowManager.hyprland.plugins = [
  #   inputs.hypr-dynamic-cursors.packages.${pkgs.stdenv.hostPlatform.system}.hypr-dynamic-cursors
  # ];

  programs.aether = {
    enable = true;
    hyprland = {
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}

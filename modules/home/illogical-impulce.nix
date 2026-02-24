{ inputs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    sharedModules = [
      inputs.illogical-flake.homeManagerModules.default
    ];
    users.user = {
      home.stateVersion = "25.11";
      programs.illogical-impulse = {
        enable = true;
      };
    };
  };
}

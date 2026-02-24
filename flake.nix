{
  description = "MoonVeil flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/dd220efe7b1e292415bd0ea7161f63df9c95bfd3"; # v0.53.3
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # dotfiles = {
    #   url = "path:.";
    #   flake = false;
    # };
    illogical-flake = {
      url = "github:strtab/illogical-flake/b6b9176131accdd2f3a3b655e30db828b95a98ef";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.dotfiles.follows = "dotfiles"; # Override to use your dotfiles
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      illogical-flake,
      ...
    }@inputs:
    {
      nixosConfigurations.moonveil = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./modules/system/configuration.nix
          ./modules/packages/packages.nix
          ./modules/home/illogical-impulce.nix
        ];
      };
    };
}

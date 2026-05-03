{
  # https://github.com/strtab/nix-flake
  description = ''
    My nixos flake.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/dd220efe7b1e292415bd0ea7161f63df9c95bfd3"; # v0.53.3
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles = {
      url = "path:./home/system/illogical-impulce/";
      flake = false;
    };
    illogical-flake = {
      url = "gitlab:strtab/illogical-flake/daee2afb151ab7b49ff037302d855a80a01bc2e6";
      inputs.dotfiles.follows = "dotfiles";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plymouth-circle.url = "github:strtab/plymouth_theme_material_desing_circle/b15ef5bfe87d86c39b1c30aa28bbf08b2e8cde3c";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    {
      nixosConfigurations.moonveil = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          { _module.args = { inherit inputs; }; }
          inputs.nix-index-database.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          ./hosts/desktop/configuration.nix
        ];
      };
    };
}

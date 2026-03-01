{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./bootloader.nix
    ./network.nix
    ./gpu.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      nvidia.acceptLicense = true;
    };
    overlays = [
      (final: prev: {
        v2raya = prev.callPackage ../packages/v2raya.nix { lib = prev.lib; };
      })
    ];
  };

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" # hyprland
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" # sjtu
    ];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  hardware = {
    i2c.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = false;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };

  time.timeZone = "Europe/Moscow";
  console.font = "UniCyr_8x16";

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  services = {
    desktopManager.plasma6 = {
      enableQt5Integration = true;
      enable = true;
    };

    v2raya.enable = true;
    blueman.enable = true;

    geoclue2.enable = true;
    upower.enable = true;

    # Hyprland auto login
    greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "start-hyprland";
          user = "user";
        };
        default_session = {
          command = "start-hyprland";
          user = "user";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  programs = {
    # zsh.enable = true;
    fish.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    steam.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    mtr.enable = true;
  };

  users.users.user = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # sudo capabilities
      "i2c" # brightness control
      "networkmanager"
    ];
    shell = pkgs.fish;
    # shell = pkgs.zsh;
  };

  zramSwap.enable = false;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 12 * 1024;
    }
  ];
  system.stateVersion = "25.05";
}

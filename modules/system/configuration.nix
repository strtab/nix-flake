{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./hardware
    ./network
    ./boot
  ];

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
    ksm.enable = true; # kernel same-page merging.
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

    fish.enable = true;
    nano.enable = false;

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
  };

  zramSwap.enable = false;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 20 * 1024;
    }
  ];
  system.stateVersion = "25.05";
}

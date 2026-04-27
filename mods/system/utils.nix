{ config, pkgs, ... }:
let
  configDir = config.var.configDirectory;
  autoUpgrade = config.var.autoUpgrade;
in
{
  programs = {
    gnupg.agent.enable = true;
    mtr.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  documentation = {
    enable = true;
    man.enable = true;
    doc.enable = false;
    dev.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  # enable zsh autocompletion for system packages (systemd, etc)
  environment.pathsToLink = [ "/share/zsh" ];

  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix # coreutils
    ripgrep # rg
    zoxide
    ranger # file manager
    hwinfo # hardware info
    ffmpeg
    neovim
    unrar
    unzip
    gzip
    unar
    stow # config manager
    tmux
    lsof
    vim
    git
    eza
    bat
    fzf
    fd # alternative to find
    jq

    # Dev
    pkg-config
    kubectl
    gnumake
    cmake

    # Langs
    luarocks
    python3
    nodejs
    rustc
    cargo
    lua
    gcc
    go
  ];

  system.autoUpgrade = {
    enable = autoUpgrade;
    dates = "04:00";
    flake = "${configDir}";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
    allowReboot = false;
  };
}

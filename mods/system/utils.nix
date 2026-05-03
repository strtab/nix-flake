{ pkgs, ... }:
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
    pstree
    ffmpeg
    ntfs3g
    unrar
    unzip
    gzip
    unar
    lsof
    vim
    git
    fd # alternative to find
    jq

    # Development
    pkg-config
    luarocks
    python3
    gnumake
    nodejs
    rustc
    cargo
    cmake
    lua
    gcc
    go
  ];
}

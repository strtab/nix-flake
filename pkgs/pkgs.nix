{ pkgs, inputs, ... }:
let
  custom-fonts = pkgs.callPackage ./fonts.nix { inherit pkgs; };
  pkgsUnstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
    };
  };

  fonts.packages = with pkgs; [
    custom-fonts
    googlesans-code
    nerd-fonts.jetbrains-mono
    material-symbols # ttf-material-symbols-variable-git
    twemoji-color-font # ttf-twemoji
  ];

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

  # Exclude kde packages
  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.systemsettings
    kdePackages.kdebugsettings

    kdePackages.spectacle
    kdePackages.kmenuedit
    kdePackages.discover
    kdePackages.gwenview
    kdePackages.kwrited
    kdePackages.khelpcenter

    kdePackages.kwalletmanager
    kdePackages.kwallet
    libsForQt5.kwallet
    plasma5Packages.kwallet

    kdePackages.konsole
    kdePackages.okular
    kdePackages.kate
  ];

  environment.systemPackages = with pkgs; [
    ### Gui
    onlyoffice-desktopeditors # office packet
    zathura # pdf reader
    obsidian
    anki # flashcard program

    alacritty # term
    qbittorrent # torrent client
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default # browser
    nwjs
    lxqt.pavucontrol-qt # pavucontrol-qt
    cliphist # cliphist
    xdg-user-dirs # xdg-user-dirs

    # Utils for screenshoting
    grim
    swappy
    slurp
    hyprpicker

    # KDE
    kdePackages.dolphin # File manager
    kdePackages.dolphin-plugins
    kdePackages.kio-extras # Rar preview for dolphin
    kdePackages.ffmpegthumbs # Video preview for dolphin
    kdePackages.kdialog
    kdePackages.bluedevil

    # Wayland
    wayland-utils
    wl-clipboard
    bibata-cursors

    ### Cli
    uutils-coreutils-noprefix # coreutils
    bc # calc
    ripgrep # ripgrep
    fd # alternative to find
    jq # jq
    gh # github cli
    stow
    neovim
    vim
    git
    eza
    bat
    zoxide
    ripgrep
    fzf
    tmux
    ranger
    lshw
    hwinfo
    cmake
    gnumake

    ### network utils
    inetutils
    curlFull # curl
    wget # wget
    rsync # rsync
    dig
    nmap

    ### Archivers
    # also, KDE has ark
    unzip
    gzip
    unrar

    ### Dev
    kubectl
    ansible

    ### Media
    ffmpeg
    grim
    vlc
    imv

    pulseaudio # pulseaudio utils

    ### Langs
    nodejs
    python3
    python313Packages.pip
    rustc
    cargo
    luarocks
    lua
    gcc
    go
  ];
}

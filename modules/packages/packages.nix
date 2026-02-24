{ pkgs, inputs, ... }:
let
  gruvbox-plus-icons = pkgs.callPackage ./gruvbox-plus-icons.nix { inherit pkgs; };
  custom-fonts = pkgs.callPackage ./fonts.nix { inherit pkgs; };
  pkgsUnstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  # Note: The following generate files under ~/.config/fontconfig/conf.d/
  # fontconfig may rely on this to properly find fonts installed via Nix.
  fonts.fontconfig.enable = true;

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

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.systemsettings
    kdePackages.kdebugsettings

    kdePackages.spectacle
    kdePackages.kmenuedit
    kdePackages.discover
    kdePackages.gwenview
    kdePackages.kwrited

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
    zathura
    obsidian
    qbittorrent
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default # browser
    wayland-utils
    wl-clipboard
    alacritty
    nwjs
    fontconfig # fontconfig
    lxqt.pavucontrol-qt # pavucontrol-qt
    cliphist # cliphist
    xdg-user-dirs # xdg-user-dirs

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

    ### themes
    gruvbox-plus-icons # Icon pack
    bibata-cursors

    ### Cli
    uutils-coreutils-noprefix # coreutils
    rsync # rsync
    bc # calc
    curlFull # curl
    wget # wget
    ripgrep # ripgrep
    jq # jq
    gh # github cli
    stow
    neovim
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
    inetutils # network utils
    dex # run applications with *.desktop file
    cmake

    ### Archivers
    unzip
    gzip
    unrar

    ### Dev
    kubectl
    ansible

    ### Media
    ffmpeg
    vlc
    imv
    grim

    pulseaudio # pulseaudio utils

    ### Langs
    nodejs
    python3
    rustc
    cargo
    gcc
    go
  ];
}

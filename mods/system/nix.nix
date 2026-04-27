{
  config,
  inputs,
  ...
}:
let
  autoGarbageCollector = config.var.autoGarbageCollector;
in
{
  services.envfs.enable = true; # Dynamic populates contents of /bin
  programs = {
    nix-ld.enable = true; # Dynamic liblaries
    nix-index-database.comma.enable = true; # Comma
    nh.enable = true; # Nix helper
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    channel.enable = true;
    extraOptions = ''
      warn-dirty = false
    '';
    settings = {
      download-buffer-size = 262144000; # 250 MB (250 * 1024 * 1024)
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        # "https://cache.nixos.org"
      ];
    };
    gc = {
      automatic = autoGarbageCollector;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  security.sudo.extraConfig = ''
    Defaults timestamp_type=tty,timestamp_timeout=-1
  '';

  security.sudo.extraRules = [
    {
      users = [ config.var.username ];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}

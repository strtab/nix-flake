{ inputs, ... }:
{
  services.envfs.enable = true; # Dynamic populates contents of /bin
  programs = {
    nix-index-database.comma.enable = true; # Comma
    nix-ld.enable = true; # Dynamic liblaries
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
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        # "https://cache.nixos.org"
      ];
    };
  };
}

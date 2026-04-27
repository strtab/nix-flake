{ config, lib, ... }:
{
  config.var = {
    hostname = "moonveil";
    username = "user";
    configDirectory = "/home/" + config.var.username + "/.flake"; # The path of the nixos configuration directory

    keyboardLayout = "en,ru";

    git = {
      username = "strtab";
      email = "nixjoyer@gmail.com";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  # DON'T TOUCH THIS
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}

{ lib, ... }:
{
  config.var = {
    hostname = "moonveil";
    username = "user";

    keyboardLayout = "en,ru";

    git = {
      username = "strtab";
      email = "nixjoyer@gmail.com";
    };
  };

  # DON'T TOUCH THIS
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}

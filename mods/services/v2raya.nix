{ pkgs, ... }:
{
  services.v2raya.package = pkgs.v2raya.overrideAttrs (old: {
    version = "2.2.7.5";
    src = pkgs.fetchFromGitHub {
      owner = "v2rayA";
      repo = "v2rayA";
      tag = "v2.2.7.5";
      hash = "sha256-gZ9vF1xwDZblBwG9U3X+aWFqcH7S6pIya8dvLorv5zk=";
    };
  });

  services.v2raya.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.systemd1.manage-units" &&
          action.lookup("unit") == "v2raya.service") {
        return polkit.Result.YES;
      }
    });
  '';
}

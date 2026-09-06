{ config, ... }:
let
  maildir = "${config.home.homeDirectory}/.local/share/mail";
in
{
  home.sessionVariables.MAILDIR = "${maildir}/";

  imports = [
    ./aerc.nix
    ./isync.nix
    ./notmuch.nix
    ./goimapnotify.nix
  ];
}

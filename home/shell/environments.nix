{
  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "$HOME/.go/bin"
    ".venv/bin"
    "$HOME/.local/bin"
    "$HOME/.npm-global/bin"
  ];

  home.sessionVariables = {
    GOPATH = "$HOME/.go";
    EDITOR = "nvim";
  };
}

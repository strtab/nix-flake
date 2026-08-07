{ ... }:
{
  programs.obsidian = {
    enable = true;
  };
  home.shellAliases = {
    notes = "nvim --cmd 'cd ~/.obsidian/notes'";
    note = "nvim --cmd 'cd ~/.obsidian/notes'";
  };
}

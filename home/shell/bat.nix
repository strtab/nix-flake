{
  programs.bat = {
    enable = true;
  };

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };

  home.shellAliases = {
    "less" = "bat --paging=always --style=plain";
    "cat" = "bat --no-pager --style=plain";
    "cpuinfo" = "bat -l cpuinfo /proc/cpuinfo";
    "dfc" = "df -h -x tmpfs -x devtmpfs -x efivarfs | bat --style=plain -l help";
    "free" = "free -ht 2>&1 | bat -l cpuinfo --style=plain";
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf config.var.git.enable {
      home.shellAliases = {
        "gl" = "git l";
        "gla" = "git la";
        "gld" = "git ld";
        "ga" = "git add";
        "gs" = "git status";
        "gc" = "git commit";
        "gcl" = "git clone --depth 1 --recursive";
        "gr" = "git restore --staged";
      };
      home.packages = [ pkgs.gh ];
      programs.git = {
        enable = true;
        settings = {
          github = {
            user = config.var.git.username;
          };
          user = {
            email = config.var.git.email;
            name = config.var.fullname;
            signingkey = config.var.git.email;
          };
          color = {
            advice = true;
            branch = true;
            diff = true;
            grep = true;
            interactive = true;
            pager = true;
            push = true;
            remote = true;
            showBranch = true;
            status = true;
            transport = true;
            ui = true;
          };
          init.defaultBranch = "main";
          branch.autoSetupRebase = "always";
          fetch.prune = true;
          pull.rebase = true;
          rerere.enabled = true;
          rebase.autoStash = true;
          push.autoSetupRemote = true;
          merge.conflictStyle = "diff3";

          format.pretty = "lf";

          # Pretty formats
          pretty = {
            lo = "tformat:%C(auto)%h%C(reset)%C(auto)%d%C(reset) %s %C(italic blue)%ad%C(reset) %C(241)%aN%C(reset)";
            lc = "format:%C(auto)%h%C(reset) %C(white)-%C(reset) %C(italic blue)%ad%C(reset) %C(italic cyan)(%ar)%C(reset)%C(auto)%d%C(reset)%n %C(white)%C(reset) %s %C(241)- %aN <%aE>%C(reset)%n";
            lt = "format:%C(auto)%h%C(reset) %C(white)-%C(reset) %C(italic blue)%ad%C(reset) %C(italic cyan)(%ar)%C(reset)%C(auto)%d%C(reset)%n %C(white)%C(reset) %s %C(241)- %aN <%aE>%C(reset)%n%w(0,7,7)%+(trailers:only,unfold)";
            lf = "format:%C(auto)%h%C(reset)%C(auto)%d%C(reset)   %C(italic 239)[P: %p] [T: %t]%C(reset)%n%C(white)Author:%C(reset)   %aN %C(241)<%aE>%C(reset)%n          %C(italic blue)%ad%C(reset) %C(italic cyan)(%ar)%C(reset)%n%C(white)Commit:%C(reset)   %cN %C(241)<%cE>%C(reset)   %C(italic 239)[GPG: %G?% GK]%C(reset)%n          %C(italic blue)%cd%C(reset) %C(italic cyan)(%cr)%C(reset)%w(0,4,4)%n%n%C(bold)%s%C(reset)%n%n%-b%n%n%-N%n";
            rlo = "tformat:%C(auto)%h%C(reset) %C(bold yellow)(%C(magenta)%gd%C(bold yellow))%C(reset)%C(auto)%d%C(reset) %gs %C(italic blue)%ad%C(reset) %C(241)%aN%C(reset)";
            rlc = "format:%C(auto)%h%C(reset) %C(white)-%C(reset) %C(italic blue)%ad%C(reset) %C(italic cyan)(%ar)%C(reset)%C(auto)%d%C(reset)%n %C(white)%C(reset) %s %C(241)- %aN <%aE>%C(reset)%n %C(white)⤷%C(reset) %C(bold yellow)(%C(magenta)%gd%C(bold yellow))%C(reset) %gs %C(241)- %gN <%gE>%C(reset)%n";
            rlf = "format:%C(auto)%h%C(reset) %C(bold yellow)(%C(magenta)%gd%C(bold yellow))%C(reset)%C(auto)%d%C(reset)   %C(italic 239)[P: %p] [T: %t]%C(reset)%n%C(white)Author:%C(reset)   %aN %C(241)<%aE>%C(reset)%n          %C(italic blue)%ad%C(reset) %C(italic cyan)(%ar)%C(reset)%n%C(white)Commit:%C(reset)   %cN %C(241)<%cE>%C(reset)   %C(italic 239)[GPG: %G?% GK]%C(reset)%n          %C(italic blue)%cd%C(reset) %C(italic cyan)(%cr)%C(reset)%n%C(white)Reflog:%C(reset)   %gN %C(241)<%gE>%C(reset)%n          %C(italic)%gs%C(reset)%w(0,4,4)%n%n%C(bold)%s%C(reset)%n%n%-b%n%n%-N%n";
          };

          # Aliases
          alias = {
            # log
            l = "log --pretty=lc --graph --date=human";
            ls = "log --pretty=lo --graph --date=human --simplify-by-decoration";
            ld = "log --pretty=lf --graph --cc --stat";
            lp = "log --pretty=lf --graph --cc --patch";
            la = "log --pretty=lc --graph --all";
            lao = "log --pretty=lo --graph --date=human --all";
            las = "log --pretty=lo --graph --date=human --simplify-by-decoration --all";
            laf = "log --pretty=lf --graph --all";
            lad = "log --pretty=lf --graph --cc --stat --all";
            lap = "log --pretty=lf --graph --cc --patch --all";
            lg = "log --pretty=lc --graph --branches=* --tags=* --remotes=origin --remotes=upstream";
            lgo = "log --pretty=lo --graph --date=human --branches=* --tags=* --remotes=origin --remotes=upstream";
            lgs = "log --pretty=lo --graph --date=human --simplify-by-decoration --branches=* --tags=* --remotes=origin --remotes=upstream";
            lgf = "log --pretty=lf --graph --branches=* --tags=* --remotes=origin --remotes=upstream";
            lgd = "log --pretty=lf --graph --cc --stat --branches=* --tags=* --remotes=origin --remotes=upstream";
            lgp = "log --pretty=lf --graph --cc --patch --branches=* --tags=* --remotes=origin --remotes=upstream";

            # reflog
            rl = "reflog --pretty=rlc";
            rlo = "reflog --pretty=rlo";
            rlf = "reflog --pretty=rlf";
            rld = "reflog --pretty=rlf --stat";

            # stash
            sl = "stash list --pretty=rlc";
            slo = "stash list --pretty=rlo";
            slf = "stash list --pretty=rlf";
            sld = "stash list --pretty=rlf --stat";
            slp = "stash list --pretty=rlf --patch";
            sls = "stash show --patch";

            # inspection
            sh = "show --stat --cc --summary --patch";
            grep = "grep -Ii";
            desc = "describe --abbrev=0";
            descl = "describe --long";

            # diff
            d = "diff -c";
            ds = "diff --find-renames --stat --cc -c";
            dc = "diff --cached -c";
            dl = "diff --cached -c HEAD~";
            du = "diff --cached -c @{u}";
            dr = "!f() { git diff -c ${"1:-HEAD"}~..${"1:-HEAD"}; }; f";

            # status
            s = "status";
            si = "status --ignored";
            sa = "status --ignored --untracked-files";

            # index
            a = "add";
            aa = "add --all";
            au = "add --update";
            ai = "add --interactive";
            ap = "add --patch";
            an = "add --intent-to-add";
            u = "reset HEAD --";
            up = "reset --patch HEAD --";

            # commit
            c = "commit";
            cn = "commit --no-verify";
            cc = "commit -c";
            cf = "commit --fixup";
            cs = "commit --squash";
            ca = "commit --amend";
            can = "commit --amend --no-edit";

            # checkout
            co = "checkout";
            com = "checkout master --";
            cod = "checkout develop --";
            cob = "checkout -b";
            cop = "checkout --patch HEAD --";

            # branch
            b = "branch";
            bc = "branch --contains";
            bd = "branch --delete --force";
            bl = "branch -vv";
            bla = "branch --all -vv";

            # tag
            t = "tag";
            tc = "tag --contains";
            td = "tag --delete";

            # network (in)
            cl = "clone";
            p = "pull";
            f = "fetch --tags";
            ff = "fetch --force --prune --tags";
            fa = "fetch --all --tags";
            ffa = "fetch --all --force --prune --tags";
            pfa = "!f() { git remote | xargs -I@ -P0 git fetch --tags \"$@\" @; }; f";

            # network (out)
            pu = "push";
            puf = "push --force-with-lease";
            puff = "push --force";
            pun = "push --no-verify";
            punf = "push --no-verify --force-with-lease";
            punff = "push --no-verify --force";

            # submodule
            sub = "submodule";
            subu = "submodule update --init --recursive";

            # merge
            m = "merge";
            ma = "merge --abort";
            mc = "merge --continue";
            mff = "merge --ff-only";
            mnc = "!f() { git merge --no-commit --no-ff \"$@\"; EC=$?; git merge --abort; exit $EC; }; f";

            # rebase
            r = "rebase";
            ra = "rebase --abort";
            rc = "rebase --continue";
            rq = "rebase --quit";
            rs = "rebase --skip";
            ret = "rebase --edit-todo";
            rsh = "rebase --show-current-patch";

            # interactive rebase
            ri = "rebase --interactive";
            rin = "rebase --interactive --no-autosquash";
            riu = "rebase --interactive @{u}";
            rim = "rebase --interactive master";
            rid = "rebase --interactive develop";

            # cherry-pick
            cp = "cherry-pick";
            cpa = "cherry-pick --abort";
            cpc = "cherry-pick --continue";
            cpq = "cherry-pick --quit";

            # revert
            rv = "revert";
            rva = "revert --abort";
            rvc = "revert --continue";
            rvq = "revert --quit";

            # reset
            re = "reset";
            res = "reset --soft";
            reh = "reset --hard";
          };
        };
      };
    })
  ];
}

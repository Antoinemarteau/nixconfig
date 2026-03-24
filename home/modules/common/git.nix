{ pkgs, ...}:
{
    programs.git = {
        enable = true;
        package = pkgs.gitFull;

        settings = {
            user.email = "antoine.marteau@protonmail.com";
            user.name = "Antoine Marteau";
            core.editor = "nvim";
            github.user = "Antoinemarteau";
            mergetool.prompt = false;
            pull.rebase = false;
        };
    };

    home.shellAliases = {
        g   = "git";
        gc  = "git checkout";
        gps = "git push --set-upstream";
        gs  = "git status";
        gd  = "git diff";
        gf  = "git fetch";
    };
}

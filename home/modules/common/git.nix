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
        ga  = "git add";
        gc  = "git commit";
        gpl = "git pull";
        gps = "git push";
        gs  = "git status";
        gd  = "git diff";
        gf  = "git fetch";
    };
}

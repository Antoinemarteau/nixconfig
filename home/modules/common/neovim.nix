{ my-nvim, ...}:
{

    home = {
        packages = [
            my-nvim
        ];
        shellAliases = {
            vim= "nvim";
            vi = "nvim";
            v  = "nvim";
        };
        sessionVariables.EDITOR = "nvim";
    };
}

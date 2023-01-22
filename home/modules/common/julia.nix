{ pkgs, ... }:
{
    home = {
        shellAliases = {
            ju = "julia";
        };

        sessionVariables = {
            JULIA_LOAD_PATH = "$HOME/prog/these/julia:$JULIA_LOAD_PATH";
        };

        packages = with pkgs; [ julia-bin ];
    };
}

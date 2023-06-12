{ pkgs, ... }:
{
    imports = [
        ./settings.nix
        ./keymappings.nix
        ./autocommands.nix
        ./colorscheme.nix
        ./plugins
    ];

    xdg.configFile."nvim/UltiSnips".source = ./nvim/UltiSnips;
    xdg.configFile."nvim/ftplugin".source = ./nvim/ftplugin;

    programs.nixvim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        luaLoader.enable = true;

        extraPackages = with pkgs; [
        ];
    };

    home = {
        shellAliases.v = "nvim";
        sessionVariables.EDITOR = "nvim";
    };
}

{ pkgs, ... }:

{
    imports = [
        ./settings.nix
        ./keymappings.nix
        ./autocommands.nix
        ./colorscheme.nix
        ./plugins
    ];

    # xdg.configFile.nvim-ultisnips.source = ./nvim;

    programs.nixvim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        luaLoader.enable = true;

        extraPackages = with pkgs; [

        #    nodePackages.neovim
        #    nodejs
        #    tree-sitter
        #    yarn                        # Needed to install Markdown-preview plugin

        #    # Language servers
        #    nodePackages.bash-language-server           # Bash language server
        #    lua-language-server                         # Lua language server
        #    clang-tools                                 # C/C++ language server
        #    texlab                                      # LaTeX language server
            ltex-ls                                     # LaTeX language server
        #    xdotool                                     # For forward search in zathura
        #    pstree                                      # For inverse search in vimtex
        #    rnix-lsp                                    # Nix language server
        ];
    };

    home = {
        shellAliases.v = "nvim";
        sessionVariables.EDITOR = "nvim";
    };
}

{ pkgs, config, ... }:
{

    # Vim latex support with vimtex, configured with Zathura
    imports = [ ./neovim/plugins/vimtex.nix ];

    programs.nixvim = {
        plugins = {
            # Parser
            treesitter.grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [ latex ];

            # LanguageServer
            lsp.servers.texlab.enable  = true;
            lsp.servers.ltex.enable    = true;
        };

        filetype.extension = {
            pdf_tex = "tex";
        };
    };

    home.packages = with pkgs; [
        texlive.combined.scheme-full
        inkscape # for svg support
    ];
}


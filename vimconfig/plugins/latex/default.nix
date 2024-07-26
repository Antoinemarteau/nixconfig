{ pkgs, config, ... }:
{

   # Vim latex support with vimtex, configured with Zathura
   imports = [ ./vimtex.nix ];

   plugins = {
       # Parser
       treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [ latex ];

       # LanguageServer
       lsp.servers.texlab.enable  = true;
       lsp.servers.ltex.enable    = true;
   };

   filetype.extension = {
       pdf_tex = "tex";
   };

   files."ftplugin/tex.lua".localOpts = {
       textwidth = 80;
       sidescrolloff = 0;
   };
}


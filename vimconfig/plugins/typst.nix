{ config, helpers, lib, ... }:
{

  dependencies.typst.enable = true;

  plugins = {
    typst-vim.enable = true;
    typst-preview.enable = true;

    # Parser
    treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [ typst ];

    # LanguageServer
    lsp.servers.tinymist.enable  = true;
  };

  keymaps = let
      normal =
        lib.mapAttrsToList
        (key: action: {
          mode = "n";
          inherit action key;
        })
        {
          "<localleader>t" = ":TypstPreviewToggle<CR>";
          "<localleader>c" = ":TypstPreviewFollowCursorToggle<CR>";
        };
    in
      helpers.keymaps.mkKeymaps
      {options.silent = true;}
      normal;

  globals = {
    typst_embedded_languages = ["python" "julia"];
  };

  files."ftplugin/typ.lua".localOpts = {
    textwidth = 80;
    sidescrolloff = 0;
  };
}


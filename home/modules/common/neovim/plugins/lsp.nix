{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<A-s>" = "goto_prev";
            "<A-t>" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gr = "references";
            gt = "type_definition";
            gi = "implementation";
            gk = "hover";
            gf = "format";
            ga = "code_action";
            gy = "document_symbol";
            "<F2>" = "rename";
          };
        };

        servers = {
          bashls.enable  = true;
          clangd.enable  = true;
          texlab.enable  = true;
          ltex.enable    = true;
          lua-ls.enable  = true;
          pylsp.enable   = true;
        };
      };
    };
  };
}


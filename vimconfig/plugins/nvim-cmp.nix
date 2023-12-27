{
  config = {

    options.completeopt = ["menu" "menuone" "noselect"];

    # nice icons in completion menu
    plugins = {
      lspkind = {
        enable = true;
        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
            neorg = "[neorg]";
            cmp_tabnine = "[TabNine]";
          };
        };
      };

      nvim-cmp = {
        enable = true;

        snippet.expand = "ultisnips";

        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";

          "<C-e>" = "cmp.mapping.abort()";
          "<A-e>" = "cmp.mapping.abort()";

          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";

          "<A-t>" = "cmp.mapping.select_next_item()";
          "<A-s>" = "cmp.mapping.select_prev_item()";
        };

        sources = [
          {name = "path";}
          {name = "nvim_lsp";}
          {name = "ultisnips";}
          {
            name = "buffer";
            option = { # all buffers
              get_bufnrs.__raw = ''function()
                    return vim.api.nvim_list_bufs()
                  end
              '';
            };
            #option = { # all visible buffers
            #  get_bufnrs.__raw = ''function()
            #    local bufs = {}
            #    for _, win in ipairs(vim.api.nvim_list_wins()) do
            #      bufs[vim.api.nvim_win_get_buf(win)] = true
            #    end
            #    return vim.tbl_keys(bufs)
            #  end
            #'';
            #};
          }
          #{name = "cmp_tabnine";}
        ];
      };
    };

    extraConfigLua = ''
      -- mappings for accepting the Nth item in list
      local function confirm_Nth_item(N)
          local cmp = require('cmp')
          if not (cmp == nil) then
              for _ = 1, N do
                  cmp.select_next_item()
              end
              cmp.confirm()
          end
      end

      vim.keymap.set('i', '<A-v>', function() confirm_Nth_item(1) end, { silent = true })
      vim.keymap.set('i', '<A-d>', function() confirm_Nth_item(2) end, { silent = true })
      vim.keymap.set('i', '<A-l>', function() confirm_Nth_item(3) end, { silent = true })
      vim.keymap.set('i', '<A-j>', function() confirm_Nth_item(4) end, { silent = true })
      vim.keymap.set('i', '<A-à>', function() confirm_Nth_item(5) end, { silent = true })
    '';
  };
}

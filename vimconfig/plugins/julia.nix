{ pkgs, config, ...}:
{
  # julia-vim
  extraPlugins = [ pkgs.vimPlugins.julia-vim ];
  globals.latex_to_unicode_keymap = true;

  plugins = {
    # Parser
    treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [ julia ];

    # LanguageServer
    lsp.servers.julials.enable = true;

    vim-slime = {
      enable = true;

      settings = {
        default_config = {
          socket_name = "default";
          target_pane = ":{end}.{right}";
        };
        target = "tmux";
        dont_ask_default = true;
        paste_file = "$XDG_CACHE_HOME/slime_paste";
        cell_delimiter = "##";
        cell_delimiter_cells_by = "tags";
      };
    };

    julia-cell = {
      enable = true;

      settings.delimit_cells_by = "tags";

      keymaps = {
          silent          = true;
          clear           = "<Leader>jl";
          executeCell     = "<Leader>jc";
          executeCellJump = "<Leader>jC";
          nextCell        = "<Leader>jn";
          prevCell        = "<Leader>jp";
          run             = "<Leader>jr";
      };
    };
  };

  keymaps = [
      # execute the current line or current selection
      {
          mode = "v";
          key = "<Leader>je";
          action = "<Plug>SlimeRegionSend";
          options.silent = true;
      }
      {
          key = "<Leader>je";
          action = "<Plug>SlimeLineSend";
          options.silent = true;
      }
      {
          key = "<Leader>e";
          action = "<Plug>SlimeSendCell";
          options.silent = true;
      }
      # save and run script
      {
          key = "<F5>";
          action = ":w<CR>:JuliaCellRun<CR>";
          options.silent = true;
      }
  ];
}

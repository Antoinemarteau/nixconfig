{ pkgs, config, ...}:
{
  # julia-vim
  extraPlugins = [ pkgs.vimPlugins.julia-vim ];
  globals.latex_to_unicode_keymap = true;

  files."ftplugin/julia.lua".localOpts = {
    tabstop = 2;     # Number of spaces a <Tab> in the text stands for (local to buffer)
    shiftwidth = 2;  # Number of spaces used for each step of (auto)indent (local to buffer)
    softtabstop = 2; # If non-zero, number of spaces to insert for a <Tab> (local to buffer)
  };

  plugins = {
    # Parser
    treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [ julia ];

    # LanguageServer, but is installed in startup.jl in home-manager
    lsp.servers.julials = {
        enable = true;
        package = null;
    };

    vim-slime = {
      enable = true;

      settings = {
        default_config = {
          socket_name = "default";
          target_pane = ":{end}.{right}";
        };
        target = "tmux";
        dont_ask_default = 1;
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
      # execute the lines in the current paragraph
      {
          mode = "n";
          key = "<Leader>p";
          action = "<Plug>SlimeParagraphSend";
          options.silent = true;
      }
      # execute the lines according to next motion
      {
          mode = "n";
          key = "<Leader>e";
          action = "<Plug>SlimeMotionSend";
          options.silent = true;
      }
      # execute the selected lines
      {
          mode = "v";
          key = "<Leader>e";
          action = "<Plug>SlimeRegionSend";
          options.silent = true;
      }
      # execute the current line and go down one line
      {
          key = "<Leader>l";
          action = "<Plug>SlimeLineSend<CR>";
          options.silent = true;
      }
      # execute the current cell
      {
          key = "<Leader>c";
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

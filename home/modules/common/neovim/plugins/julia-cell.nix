{ config, ... }:
{
  programs.nixvim = {
    plugins = {
      vim-slime = {
        enable = true;

        target = "tmux";
        defaultConfig = {
          socket_name = "default";
          target_pane = ":{end}.{right}";
        };
        dontAskDefault = true;
        #pasteFile = "$(XDG_CACHE_HOME)/slime_paste";

        extraConfig = {
          cell_delimiter = "##";
          cell_delimiter_cells_by = "tags";
        };
      };

      julia-cell = {
        enable = true;

        delimitCellsBy = "tags";

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

    maps = config.nixvim.helpers.mkMaps {silent = true;} {
        # execute the current line or current selection
      visual."<Leader>je" = "<Plug>SlimeRegionSend";
      normal = {
        # execute the current line or current selection
        "<Leader>je" = "<Plug>SlimeLineSend";
        "<Leader>e"  = "<Plug>SlimeSendCell";

        # save and run script
        "<F5>" = ":w<CR>:JuliaCellRun<CR>";
      };
    };
  };
}

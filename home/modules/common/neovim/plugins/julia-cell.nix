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
        pasteFile = "${config.xdg.cacheHome}/slime_paste";

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
  };
}

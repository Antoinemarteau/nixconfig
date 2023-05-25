{ pkgs, config, ... }:
{
  programs.nixvim = {

    extraPlugins = [
      pkgs.vimPlugins.vim-slime
    ];

    extraConfigLua = ''
      --require('oil').setup ({
      --  columns = {
      --    "icon",
      --    "size"
      --  },
      --})
    '';

    globals = {
      # slime globals
      slime_target = "tmux";
      slime_default_config = {
          socket_name = "default";
          target_pane = ":{end}.{right}";
      };
      slime_dont_ask_default = 1;
      slime_cell_delimiter = "##";

      # julia-cell configuration
      julia_cell_delimit_cells_by = "tags";
    };

    maps = config.nixvim.helpers.mkMaps {silent = true;} {
        # execute the current line or current selection
      visual."<Leader>je" = "<Plug>SlimeRegionSend";
      normal = {
        # execute the current line or current selection
        "<Leader>je" = "<Plug>SlimeLineSend";
        "<Leader>e"  = "<Plug>SlimeSendCell";

        # run entire file
        "<Leader>jr" = ":JuliaCellRun<CR>";

        # execute the current cell
        "<Leader>jc" = ":JuliaCellExecuteCell<CR>";

        # execute the current cell and jump to the next cell
        "<Leader>jC" = ":JuliaCellExecuteCellJump<CR>";

        # map <Leader>jl to clear Julia screen
        "<Leader>jl" = ":JuliaCellClear<CR>";

        # jump to the previous and next cell header
        "<Leader>jp" = ":JuliaCellPrevCell<CR>";
        "<Leader>jn" = ":JuliaCellNextCell<CR>";

        # save and run script
        "<F5>" = ":w<CR>:JuliaCellRun<CR>";
      };
    };
  };
}

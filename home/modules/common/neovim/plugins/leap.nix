{ pkgs, config, ... }:
{
  programs.nixvim = {

    extraPlugins = [
      pkgs.vimPlugins.leap-nvim
    ];

    maps = config.nixvim.helpers.mkMaps {silent = true;} {
      normalVisualOp."é" = "<Plug>(leap-forward-to)";
      normalVisualOp."É" = "<Plug>(leap-backward-to)";
      normalVisualOp."gé"= "<Plug>(leap-from-window)";

      visual."x" = "<Plug>(leap-forward-till)";
      operator."x" = "<Plug>(leap-forward-till)";
      visual."X" = "<Plug>(leap-backward-till)";
      operator."X" = "<Plug>(leap-backward-till)";
    };

    extraConfigLua = ''
        local leap = require('leap')
        leap.opts.substitute_chars = { ['\r'] = '¬' }
        leap.opts.safe_labels = {
            "é", "f", "n", "u", "e", "j", "è",
              "É", "F", "N", "R", "C", "N", "U", "G", "E", "J", "È", "Z" }
    '';
  };
}

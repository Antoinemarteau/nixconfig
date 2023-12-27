{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.leap-nvim
  ];

  keymaps = [
      {
          key = "é";
          action = "<Plug>(leap-forward-to)";
          options.silent = true;
      }
      {
          key = "É";
          action = "<Plug>(leap-backward-to)";
          options.silent = true;
      }
      {
          key = "gé";
          action = "<Plug>(leap-from-window)";
          options.silent = true;
      }
      {
          mode = "v";
          key = "x";
          action = "<Plug>(leap-forward-till)";
          options.silent = true;
      }
      {
          mode = "o";
          key = "x";
          action = "<Plug>(leap-forward-till)";
          options.silent = true;
      }
      {
          mode = "v";
          key = "X";
          action = "<Plug>(leap-backward-till)";
          options.silent = true;
      }
      {
          mode = "o";
          key = "X";
          action = "<Plug>(leap-backward-till)";
          options.silent = true;
      }
  ];

  extraConfigLua = ''
      local leap = require('leap')
      leap.opts.substitute_chars = { ['\r'] = '¬' }
      leap.opts.safe_labels = {
          "é", "f", "n", "u", "e", "j", "è",
            "É", "F", "N", "R", "C", "N", "U", "G", "E", "J", "È", "Z" }
  '';
}

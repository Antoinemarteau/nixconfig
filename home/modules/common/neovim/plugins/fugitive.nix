{ config, ... }:
{
  programs.nixvim = {
    plugins.fugitive = {
      enable = true;
    };

    globals = {
      nremap = { r = "h"; s = "k"; }; # c = "l";
      oremap = { r = "h"; s = "k"; }; # c = "l";
      xremap = { r = "h"; s = "k"; }; # c = "l";
    };

    maps = config.nixvim.helpers.mkMaps {silent = true;} {
      normal = {
        "<leader>,s" = ":vert Git<CR>";
        "<leader>,b" = ":GBranches<CR>";
        "<leader>,t" = ":Git pull<CR>";
        "<leader>,p" = ":Git push<CR>";
        "<leader>,c" = ":diffget //2<CR>";
        "<leader>,r" = ":diffget //3<CR>";
      };
    };
  };
}

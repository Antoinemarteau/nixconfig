{ helpers, lib, ... }:
{
  plugins.fugitive = {
    enable = true;
  };

  globals = {
    nremap = { r = "h"; s = "k"; }; # c = "l";
    oremap = { r = "h"; s = "k"; }; # c = "l";
    xremap = { r = "h"; s = "k"; }; # c = "l";
  };

  keymaps = let
      normal =
        lib.mapAttrsToList
        (key: action: {
          mode = "n";
          inherit action key;
        })
        {
          "<leader>,s" = ":vert Git<CR>";
          "<leader>,t" = ":Git pull<CR>";
          "<leader>,p" = ":Git push<CR>";
          "<leader>,c" = ":diffget //2<CR>";
          "<leader>,r" = ":diffget //3<CR>";
          "<leader>,b" = ":Git branch<CR>";
          "<leader>,a" = ":Git blame<CR>";
        };
    in
      helpers.keymaps.mkKeymaps
      {options.silent = true;}
      normal;
}

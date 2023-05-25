{pkgs, ... }:
{
  imports = [
    ./comment.nix
    ./fugitive.nix
    ./julia-cell.nix
    ./lsp.nix
    ./markdown-preview.nix
    ./nvim-cmp.nix
    ./oil.nix
    ./packer.nix
    ./telescope.nix
    ./treesitter.nix
    ./ultisnips.nix # TODO
    ./vimtex.nix
  ];

  programs.nixvim = {
    plugins = {
      # git diff on left side
      gitsigns = {
        enable = true;
        signs = {
          add.text = "+";
          change.text = "~";
        };
      };
      # barre
      airline = {
        enable = true;
        powerline = true;
      };
    };

    extraPlugins = [
      pkgs.vimPlugins.julia-vim
      pkgs.vimPlugins.vim-autoformat
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
      # julia-vim
      latex_to_unicode_keymap = true;
    };

    # vim-autoformat
    maps.normal."<leader>a" = {
      action = ":Autoformat<CR>";
      silent = true;
    };

  };
}

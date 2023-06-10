{pkgs, ... }:
{
  imports = [
    ./comment.nix
    ./fugitive.nix
    ./harpoon.nix
    ./julia-cell.nix
    ./leap.nix
    ./lsp.nix
    ./markdown-preview.nix
    ./nvim-cmp.nix
    ./oil.nix
    ./packer.nix
    ./telescope.nix
    ./treesitter.nix
    ./ultisnips.nix
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
        theme = "base16_gruvbox_dark_hard";
      };
    };

    extraPlugins = [
      pkgs.vimPlugins.julia-vim
      pkgs.vimPlugins.vim-autoformat
    ];

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

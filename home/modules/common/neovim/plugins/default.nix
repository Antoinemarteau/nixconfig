{pkgs, ... }:
{
  imports = [
    ./comment.nix
    ./fugitive.nix
    ./harpoon.nix
    ./leap.nix
    ./lsp.nix
    ./markdown-preview.nix
    ./nvim-cmp.nix
    ./oil.nix
    ./packer.nix
    ./telescope.nix
    ./treesitter.nix
    ./ultisnips.nix
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
      pkgs.vimPlugins.vim-autoformat
    ];

    # vim-autoformat
    keymaps = [
        {
            key = "<leader>a";
            action = ":Autoformat<CR>";
            options.silent = true;
        }
    ];

  };
}

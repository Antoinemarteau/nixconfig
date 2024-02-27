{pkgs, ... }:
{
  imports = [
    ./comment.nix
    ./fugitive.nix
    ./harpoon.nix
    ./julia.nix
    ./latex
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

  plugins = {
    # git diff on left side + preview hunk and diff
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

  keymaps = [
  # vim-autoformat
      {
          key = "<leader>a";
          action = ":Autoformat<CR>";
          options.silent = true;
      }
  # gitsigns
      {
          key = "<leader>,b";
          action = ":Gitsigns toggle_current_line_blame<CR>";
          options.silent = true;
      }
      {
          key = "<leader>,h";
          action = ":Gitsigns preview_hunk<CR>";
          options.silent = true;
      }
  ];
}

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
    #./packer.nix # unsuported apparently
    ./telescope.nix
    ./typst.nix
    ./treesitter.nix
    ./ultisnips.nix
  ];

  plugins = {
    # git diff on left side + preview hunk and diff
    gitsigns = {
      enable = true;
      settings.signs = {
        add.text = "+";
        change.text = "~";
      };
    };
    # barre
    airline = {
      enable = true;
      settings = {
          powerline_fonts = 1;
      };
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
          key = "<leader>,l";
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

{

  programs.nixvim.plugins.packer = {
      enable = true;
      plugins = [
        "mroavi/vim-julia-cell"
      ];
  };
}

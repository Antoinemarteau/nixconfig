{config, ...}:
{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;

        nixvimInjections = true;

        folding = false;
        indent = true;

        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash
          c
          cpp
          html
          julia
          latex
          lua
          nix
          python
          vimdoc
        ];
      };

      treesitter-refactor = {
        enable = true;
        highlightDefinitions.enable = true;
      };
    };

    extraConfigLua = ''
      require 'vim.treesitter.language'.register("cpp", "onelab")
    '';
  };
}


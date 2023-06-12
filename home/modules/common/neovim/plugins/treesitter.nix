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
          latex
          lua
          nix
          python
          vimdoc
        ];

        languageRegister.cpp = "onelab";
      };

      treesitter-refactor = {
        enable = true;
        highlightDefinitions.enable = true;
      };
    };
  };
}


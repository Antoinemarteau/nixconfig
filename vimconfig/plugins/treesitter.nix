{config, ...}:
{
  plugins = {
    treesitter = {
      enable = true;

      nixvimInjections = true;

      folding = false;
      settings.indent.enable = true;

      grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
        bash
        cpp
        html
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
}


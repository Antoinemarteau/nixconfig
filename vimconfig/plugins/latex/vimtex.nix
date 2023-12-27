{ helpers, lib, ... }:
{
  config = {
    plugins.vimtex = {
      enable = true;
      extraConfig = {
        view_method = "zathura";

        imaps_enabled = true;
        imaps_leader = "ç";

        quickfix_open_on_warning = false;
        quickfix_autoclose_after_keystrokes = 4;
        quickfix_ignore_filters = [
          "Underfull"
          "Overfull"
          "undefined references"
          "(re)run Biber"
          "Unused global option(s)"
          "Token not allowed in a PDF string"
          "level fixed"
          "float specifier changed to"
        ];

        toc_config = {
            name = "TOC";
            layers = "['content', 'todo']";
            resize = 1;
            split_width = 50;
            todo_sorted = 0;
            show_help = 1;
            show_numbers = 1;
            mode = 2;
        };
      };
    };

    keymaps = let
        normal =
          lib.mapAttrsToList
          (key: action: {
            mode = "n";
            inherit action key;
          })
          {
            m = ":VimtexView<CR>";
            # change commands
            lse = "<plug>(vimtex-env-change)";
            lsc = "<plug>(vimtex-cmd-change)";
            ls  ="$<plug>(vimtex-env-change-math)";
            lsd = "<plug>(vimtex-delim-change-math)";
            # toggle commands
            jsf = "<plug>(vimtex-cmd-toggle-frac)";
            jsc = "<plug>(vimtex-cmd-toggle-star)";
            jse = "<plug>(vimtex-env-toggle-star)";
            js  ="$<plug>(vimtex-env-toggle-math)";
            jsd = "<plug>(vimtex-delim-toggle-modifier)";
            jsD = "<plug>(vimtex-delim-toggle-modifier-reverse)";
          };
        visual =
          lib.mapAttrsToList
          (key: action: {
            mode = "v";
            inherit action key;
          })
          {
            # toggle commands
            jsf = "<plug>(vimtex-cmd-toggle-frac)";
            jsd = "<plug>(vimtex-delim-toggle-modifier)";
            jsD = "<plug>(vimtex-delim-toggle-modifier-reverse)";
            # text object:
            "aç"= "<Plug>(MatchitVisualTextObject)";
          };
      in
        helpers.keymaps.mkKeymaps
        {options.silent = true;}
        (normal ++ visual);

    # Old forgotten remaps
    ## Remap % en ç en normal mode
    #nmap('ç ', '<Plug>(MatchitNormalForward)')
    #nmap('gç', '<Plug>(MatchitNormalBackward)')
    #xmap('ç ', '<Plug>(MatchitVisualForward)')
    #xmap('gç', '<Plug>(MatchitVisualBackward)')
    #omap('ç ', '<Plug>(MatchitOperationForward)')
    #omap('gç', '<Plug>(MatchitOperationBackward)')
    #
    #nmap('[ç', '<Plug>(MatchitNormalMultiBackward)')
    #nmap(']ç', '<Plug>(MatchitNormalMultiForward)')
    #xmap('[ç', '<Plug>(MatchitVisualMultiBackward)')
    #xmap(']ç', '<Plug>(MatchitVisualMultiForward)')
    #omap('[ç', '<Plug>(MatchitOperationMultiBackward)')
    #omap(']ç', '<Plug>(MatchitOperationMultiForward)')

    autoCmd = [
      {
        event = ["BufEnter" "BufWinEnter"];
        pattern = "*.tex";
        command = "set filetype=tex \"| VimtexTocOpen";
      }
      # Compile on initialization ('TSDisable highlight' lets vimtex handle
      # highlighting, which lets it detect math mode and enables imaps)
      {
        event = "User";
        pattern = "VimtexEventInitPost";
        command = "TSDisable highlight | call vimtex#compiler#compile()";
      }
      # Cleanup on exit
      {
        event = "User";
        pattern = "VimtexEventQuit";
        command = "call vimtex#compiler#clean(0)";
      }
    ];

    extraConfigLua = ''
        -- Mappings mode insertion, pour macros electromag
        vim.call("vimtex#imaps#add_map", { lhs = "N", rhs = '\\nabla' })
        vim.call("vimtex#imaps#add_map", { lhs = 'b', rhs = '\\b'     })
        vim.call("vimtex#imaps#add_map", { lhs = 'h', rhs = '\\H'     })
        vim.call("vimtex#imaps#add_map", { lhs = 'l', rhs = '\\L'     })
        -- Racourcis pour ensemble
        vim.call("vimtex#imaps#add_map", { lhs = 'oe',  rhs = '\\omeSymb'  })
        vim.call("vimtex#imaps#add_map", { lhs = 'os',  rhs = '\\omsSymb'  })
        vim.call("vimtex#imaps#add_map", { lhs = 'oc',  rhs = '\\omcSymb'  })
        vim.call("vimtex#imaps#add_map", { lhs = 'on',  rhs = '\\omnSymb'  })
        vim.call("vimtex#imaps#add_map", { lhs = 'oh',  rhs = '\\omhSymb'  })
        vim.call("vimtex#imaps#add_map", { lhs = 'ode', rhs = '\\domeSymb' })
        vim.call("vimtex#imaps#add_map", { lhs = 'ods', rhs = '\\domsSymb' })
        vim.call("vimtex#imaps#add_map", { lhs = 'odc', rhs = '\\domcSymb' })
        vim.call("vimtex#imaps#add_map", { lhs = 'odn', rhs = '\\domnSymb' })
        vim.call("vimtex#imaps#add_map", { lhs = 'odh', rhs = '\\domhSymb' })
        -- Disable wrong bépo mappings
        vim.cmd( [[
            let g:vimtex_mappings_disable = {
                \ 'n': ['tsd', 'tsd', 'tsf', 'tsc', 'tse', 'csd', 'csc', 'cse', 'cs$'],
                \ 'x': ['tsd', 'tsd', 'tsf'],
                \}
                ]]
        )
    '';

    globals = {
      tex_flavor = "latex";
      tex_conceal="abdmg";
    };

    options.conceallevel = 2;
  };
}

{ pkgs, config, ... }:
{
    home.packages = with pkgs; [
        gdb
        cmake
        clang
        ccls
        valgrind
        #cppman ??
    ];

    programs.nixvim = {
        plugins = {
            # Parser
            treesitter.grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [ c cpp ];

            # LanguageServer
            lsp.servers.clangd.enable  = true;
        };


        # Acces a doc c++ cppman
        extraConfigLua = ''
            vim.cmd[[
                function! s:JbzCppMan()
                    let old_isk = &iskeyword
                    setl iskeyword+=:
                    let str = expand("<cword>")
                    let &l:iskeyword = old_isk
                    execute 'Man ' . str
                endfunction
                command! JbzCppMan :call s:JbzCppMan()
                au FileType cpp nnoremap <buffer>K :JbzCppMan<CR>
            ]]
        '';

        # Switch between header and implementation with Alt+o
        plugins.packer.plugins = [ "derekwyatt/vim-fswitch" ];
        autoCmd = [ # fixes for some file extension and special repo structure
            { event = [ "BufEnter" ] ; pattern = "*.cc";
              command = "let b:fswitchdst = 'h,hpp'"; }
            { event = [ "BufEnter" ] ; pattern = "*.h";
              command = "let b:fswitchdst = 'c,cpp,m,cc' | let b:fswitchlocs = 'reg:|include.*|src/**|'"; }
        ];
        maps = config.nixvim.helpers.keymaps.mkMaps {silent = true;} {
          normal."<A-m>" = ":FSHere<cr>";
        };
    };
}


{ config, ... }:
{
    # Source : https://idie.ru/posts/vim-modern-cpp/#enhancing-syntax-highlighting-for-modern-c
    programs.nixvim = {
        globals = {
          mapleader = " ";
          maplocalleader = "ç";
        };

        maps = config.nixvim.helpers.mkMaps {silent = true;} {
          normal."<Space>" = "<NOP>";

          # Esc to clear search results
          normal."<esc>" = ":noh<CR>";

          # Normal mode dans le terminal
          terminal."<A-g>" = "<C-\\><C-n>";

          # fix Y behaviour
          normal."Y" = "y$";

          # Rafraichir les racourcis
          normal."<leader>ç" = ":so /home/antoine/dotfiles/config/nvim/init.lua<cr>";

          normal."à" = { action = ":"; silent = false; };

          normalVisualOp = {

              ## [HJKL] -> {CTSR}
              c = "h";
              r = "l";
              t = "j";
              s = "k";
              C = "H";
              R = "L";
              T = "J";
              S = "K";
              zs = "zj";
              zt = "zk";

              # {HJKL} <- [CTSR]
              # {J} = « Jusqu"à »            (j = suivant, J = précédant
              j = "t";
              J = "T";
              # {L} = « Change »             (l = attend un mvt, L = jusqu"à la fin de ligne
              l = "c";
              L = "C";
              # {H} = « Remplace »           (h = un caractère slt, H = reste en « Remplace »
              h = "r";
              H = "R";
              # {K} = « Substitue »          (k = caractère, K = ligne
              k = "s";
              K = "S";
              #  Corollaire : correction orthographique
              "]k" = "]s";
              "[k" = "[s";
              ##  ligne écran précédente / suivante (à l"intérieur d"une phrase
              #gs = "gk";
              #gt = "gj";
              ##  onglet précédent / suivant
              #gb = "gT";
              #"gé" = "gt";
              ##  optionnel : {gB} / {gÉ} pour aller au premier / dernier onglet
              #gB   = '':exe "silent! tabfirst"<CR>'';
              #"gÉ" = '':exe "silent! tablast"<CR>'';
              #  optionnel : {g"} pour aller au début de la ligne écran
              "g\"" = "g0";

              #  Pour faciliter les manipulations de fenêtres, on utilise {ê} comme un Ctrl+W :
              "ê" = "<C-w>";
              "Ê" = "<C-w><C-w>";
              "êt" = "<C-w>j";
              "ês" = "<C-w>k";
              "êc" = "<C-w>h";
              "êr" = "<C-w>l";
              "êd" = "<C-w>s";
              "êp" = "<C-w>o";
              "ê<SPACE>" = ":vsplit<CR>";
              "ê<CR>" = ":split<CR>";
          };

          # resize with arrows
          normal."<C-Up>" = ":resize -2<CR>";
          normal."<C-Down>" = ":resize +2<CR>";
          normal."<C-Left>" = ":vertical resize +2<CR>";
          normal."<C-Right>" = ":vertical resize -2<CR>";

          # move current line up/down
          normal."<C-s>" = ":move-2<CR>";
          normal."<C-t>" = ":move+<CR>";

          # center buffer on current line after jump
          normal."<C-u>" = "<C-u>zz";
          normal."<C-d>" = "<C-d>zz";

          # Close quickfix list
          normal."<A-q>" = ":cclose<cr>";
          normal."<A-o>" = ":copen<cr>";

          # better indenting
          visual.">" = ">gv";
          visual."<" = "<gv";
          visual."<TAB>" = ">gv";
          visual."<S-TAB>" = "<gv";

          # move selected line / block of text in visual mode
          visual."S" = ":m '<-2<CR>gv=gv";
          visual."T" = ":m '>+1<CR>gv=gv";
        };

        maps = config.nixvim.helpers.mkMaps {silent = false;} {
          # Navigation & completion in command mode
          command."<A-v>" = "<C-B>";                          # Go to begining of line
          command."<A-d>" = "<S-Left>";                       # Cursor one word left
          command."<A-l>" = "<S-Right>";                      # Cursor one word right
          command."<A-j>" = "<End>";                          # Go to end of line

          command."<A-c>" = "<Up>";    # Go to parent folder  | back history command
          command."<A-r>" = "<Down>";  # Enter file/folder    | forward history command

          command."<A-\">"= "<C-W>";                          # Delete word before cursor
          command."<A-q>" = "<C-U>";                          # Delete all char before cursor
          command."<A-g>" = "<BS>";                           # Delete char before cursor
          command."<A-h>" = "<Del>";                          # Delete char after cursor
        };

        extraConfigLua = ''
            -- Navigation & completion in command mode
            local function cmap_menu_fallback(key, menu_action, fallback)
                vim.keymap.set('c', key, function()
                    return vim.fn.wildmenumode() == 1 and menu_action or fallback
                end, {expr = true})
            end
            cmap_menu_fallback('<A-t>', '<C-N>', '<Left>')  -- Next file/folder     | cursor Left
            cmap_menu_fallback('<A-s>', '<C-P>', '<Right>') -- Previous file/folder | cursor Right

            --  fix les deplacements haut bas et le tri des entrées dans Ex (nav. fichier vim)
            vim.cmd[[
                augroup netrw_dvorak_fix
                    autocmd!
                    autocmd filetype netrw call Fix_netrw_maps_for_dvorak()
                augroup END
                function! Fix_netrw_maps_for_dvorak()
                    noremap <buffer> t j
                    noremap <buffer> s k
                    noremap <buffer> k s
                endfunction
            ]]
        '';
    };
}

{ config, lib, ... }:
{
    # command mode keymaps
    imports = [./command_keymappings.nix];

    # Source : https://idie.ru/posts/vim-modern-cpp/#enhancing-syntax-highlighting-for-modern-c
    programs.nixvim = {
        globals = {
          mapleader = " ";
          maplocalleader = "ç";
        };

    # the '(' is to append a mapping without silent = true at the end
    keymaps = (let
        normVisOp =
          lib.mapAttrsToList
          (key: action: {
            mode = "";
            inherit action key;
          })
          {
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
        normal =
          lib.mapAttrsToList
          (key: action: {
            mode = "n";
            inherit action key;
          })
          {
            "<Space>" = "<NOP>";

            # Esc to clear search results
            "<esc>" = ":noh<CR>";

            # fix Y behaviour
            "Y" = "y$";

            # Rafraichir les racourcis
            "<leader>ç" = ":so /home/antoine/dotfiles/config/nvim/init.lua<cr>";


            # resize with arrows
            "<C-Up>" = ":resize -2<CR>";
            "<C-Down>" = ":resize +2<CR>";
            "<C-Left>" = ":vertical resize +2<CR>";
            "<C-Right>" = ":vertical resize -2<CR>";

            # move current line up/down
            "<C-s>" = ":move-2<CR>";
            "<C-t>" = ":move+<CR>";

            # center buffer on current line after jump
            "<C-u>" = "<C-u>zz";
            "<C-d>" = "<C-d>zz";

            # Close quickfix list
            "<A-q>" = ":cclose<cr>";
            "<A-o>" = ":copen<cr>";
          };
        visual =
          lib.mapAttrsToList
          (key: action: {
            mode = "v";
            inherit action key;
          })
          {
            # better indenting
            ">"       = ">gv";
            "<"       = "<gv";
            "<TAB>"   = ">gv";
            "<S-TAB>" = "<gv";

            # move selected line / block of text in visual mode
            "S" = ":m '<-2<CR>gv=gv";
            "T" = ":m '>+1<CR>gv=gv";
          };
        terminal = [
          {
            mode = "t";
            key = "<A-g>";
            action = "<C-\\><C-n>";
          }
        ];
      in
        config.nixvim.helpers.keymaps.mkKeymaps
        {options.silent = true;}
        (normal ++ visual ++ normVisOp ++ terminal) ++ [
            {
                mode = "n";
                key = "à";
                action = ":";
                options.silent = false;
            }
        ]);

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

local utils = require 'utils'
local vmap = utils.vmap
local nmap = utils.nmap
local xmap = utils.xmap
local tmap = utils.tmap
local cmap = utils.cmap
local map  = utils.map


nmap('<Space>', '<NOP>')

nmap('<Up>',    '<NOP>')
nmap('<Down>',  '<NOP>')
nmap('<Right>', '<NOP>')
nmap('<Left>',  '<NOP>')

-- Normal mode dans le terminal
tmap('<A-g>', '<C-\\><C-n>')

-- Esc to clear search results
nmap('<esc>', ':noh<CR>')

-- Rafraichir les racourcis
nmap('<leader>ç', ':so /home/antoine/dotfiles/config/nvim/init.lua<cr>')

-- explorer
nmap('<leader>\'', ':NvimTreeToggle<CR>')

vim.keymap.set('n', 'à', ':')

-- [HJKL] -> {CTSR}
map('c', 'h')
map('r', 'l')
map('t', 'j')
map('s', 'k')
map('C', 'H')
map('R', 'L')
map('T', 'J')
map('S', 'K')
map('zs', 'zj')
map('zt', 'zk')

-- {HJKL} <- [CTSR]
-- {J} = « Jusqu'à »            (j = suivant, J = précédant)
map('j', 't')
map('J', 'T')
-- {L} = « Change »             (l = attend un mvt, L = jusqu'à la fin de ligne)
map('l', 'c')
map('L', 'C')
-- {H} = « Remplace »           (h = un caractère slt, H = reste en « Remplace »)
map('h', 'r')
map('H', 'R')
-- {K} = « Substitue »          (k = caractère, K = ligne)
map('k', 's')
map('K', 'S')
--  Corollaire : correction orthographique
map(']k', ']s')
map('[k', '[s')
--  ligne écran précédente / suivante (à l'intérieur d'une phrase)
map('gs', 'gk')
map('gt', 'gj')
--  onglet précédent / suivant
map('gb', 'gT')
map('gé', 'gt')
--  optionnel : {gB} / {gÉ} pour aller au premier / dernier onglet
map('gB', ':exe "silent! tabfirst"<CR>')
map('gÉ', ':exe "silent! tablast"<CR>')
--  optionnel : {g"} pour aller au début de la ligne écran
map('g"', 'g0')

--  Pour faciliter les manipulations de fenêtres, on utilise {ê} comme un Ctrl+W :
map('ê', '<C-w>')
map('Ê', '<C-w><C-w>')
map('êt', '<C-w>j')
map('ês', '<C-w>k')
map('êc', '<C-w>h')
map('êr', '<C-w>l')
map('êd', '<C-w>s')
map('êp', '<C-w>o')
map('ê<SPACE>', ':vsplit<CR>')
map('ê<CR>', ':split<CR>')

-- Navigation & completion in command mode
cmap("<A-l>", '<C-B>')     -- Go to begining of line
cmap('<A-j>', '<End>')     -- Go to end of line
cmap('<A-v>', '<S-Left>')  -- Cursor one word left
cmap('<A-d>', '<S-Right>') -- Cursor one word right

local function cmap_menu_fallback(key, menu_action, fallback)
    vim.keymap.set('c', key, function()
        return vim.fn.wildmenumode() == 1 and menu_action or fallback
    end, {expr = true})
end
cmap_menu_fallback('<A-t>', '<C-N>', '<Left>')  -- Next file/folder     | cursor Left
cmap_menu_fallback('<A-s>', '<C-P>', '<Right>') -- Previous file/folder | cursor Right
cmap(              '<A-c>',          '<Up>')    -- Go to parent folder  | back history command
cmap(              '<A-r>',          '<Down>')  -- Enter file/folder    | forward history command

cmap('<A-h>', '<C-W>')    -- Delete word before cursor
cmap('<A-q>', '<BS>')     -- Delete char before cursor
cmap('<A-g>', '<Del>')    -- Delete char after cursor
cmap('<A-k>', '<C-U>')    -- Delete all char before cursor

--  fix les deplaement haut bas et le tri des entrées dans Ex (nav. fichier vim)
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

-- close by Ctrl+c
--nmap('<C-c>', ':close<CR>')

-- resize with arrows
nmap('<C-Up>', ':resize -2<CR>')
nmap('<C-Down>', ':resize +2<CR>')
nmap('<C-Left>', ':vertical resize +2<CR>')
nmap('<C-Right>', ':vertical resize -2<CR>')

-- better indenting
vmap('<TAB>', '>gv')
vmap('<S-TAB>', '<gv')

-- move selected line / block of text in visual mode
xmap('S', ':move \'<-2<CR>gv-gv')
xmap('T', ':move \'>+1<CR>gv-gv')

-- move current line up/down
nmap('<C-s>', ':move-2<CR>')
nmap('<C-t>', ':move+<CR>')

-- center buffer on current line after jump
nmap('<C-u>', '<C-u>zz')
nmap('<C-d>', '<C-d>zz')

-- Close quickfix list
-- C = Alt key
nmap('<A-q>', ':cclose<cr>')
nmap('<A-o>', ':copen<cr>')

-- Acces a doc c++ cppman
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

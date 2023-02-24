-----------------------
-- AutoCmd and stuff --
-----------------------

local autocmd = vim.api.nvim_create_autocmd

-- Vertically center document when entering insert mode
autocmd('InsertEnter', {command = 'norm zz'})

-- Remove trailing whitespace on save
autocmd('BufWrite', { command = "%s/\\s\\+$//e"})

-- Compile md notes after writing them (see notes.nix)
autocmd('BufWritePost', {
    pattern = "*notes-*.md",
    command = "silent !buildNote %:p",
})

-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd(
  "FileType", {
  pattern={"qf"},
  command=[[nnoremap <buffer> <CR> <CR>:cclose<CR>]]})


vim.g.mapleader = ' '
vim.g.maplocalleader = 'ç'

---------------
-- Providers --
---------------

-- Disable useless providers
vim.g.loaded_ruby_provider = 0      -- Ruby
vim.g.loaded_perl_provider = 0      -- Perl
vim.g.loaded_python_provider = 0    -- Python 2

--------------
-- Settings --
--------------

vim.g.do_filetype_lua = 1       -- Enable filetype matching using fast `filetype.lua`
-- vim.g.did_load_filetypes = 1    -- Disable filetype matching using slow `filetype.vim`

local o = vim.opt

o.updatetime = 100          -- Faster completion

-- Line numbers
o.relativenumber = true     -- Relative line numbers
o.number = true             -- Display the absolute line number of the current line
o.hidden = true             -- Keep closed buffer open in the background
o.clipboard = 'unnamedplus' -- Use system clipboard
o.mouse = 'a'               -- Enable mouse control
o.splitbelow = true         -- A new window is put below the current one
o.splitright = true         -- A new window is put right of the current one

o.swapfile = false          -- Disable the swap file
o.modeline = true           -- Tags such as 'vim:ft=sh'
o.modelines = 10           -- Sets the type of modelines
o.undofile = true           -- Automatically save and restore undo history
o.incsearch = true          -- Incremental search: show match for partly typed search command
o.smartcase = true          -- Override the 'ignorecase' option if the search
                            -- pattern contains upper case characters
o.scrolloff = 8             -- Number of screen lines to show around the cursor
o.cursorline = false        -- Highlight the screen line of the cursor
o.cursorcolumn = false      -- Highlight the screen column of the cursor
o.signcolumn = 'yes'        -- Whether to show the signcolumn
o.colorcolumn = '80'        -- Columns to highlight
o.wrap = false              -- Don't wrap lines
o.laststatus = 2            -- When to use a status line for the last window
o.termguicolors = true      -- Enables 24-bit RGB color in the |TUI|
o.spell = false             -- Highlight spelling mistakes (local to window)
o.shortmess = 'filnxtToOFc'
o.listchars = 'nbsp:·'      -- Point médian treated as unbreakable space
o.list = true               -- With listchars option

-- Set completeopt to have a better completion experience
o.completeopt = {'menu', 'menuone', 'noselect'}

-- Tab options
o.tabstop = 4               -- Number of spaces a <Tab> in the text stands for (local to buffer)
o.shiftwidth = 4            -- Number of spaces used for each step of (auto)indent (local to buffer)
o.softtabstop = 4           -- If non-zero, number of spaces to insert for a <Tab> (local to buffer)
o.expandtab = true          -- Expand <Tab> to spaces in Insert mode (local to buffer)
o.smartindent = true        -- Do clever autoindenting
vim.cmd("let wildchar  = '<Tab>'")  -- Trigger for completion in command mode
vim.o.wildcharm = vim.o.wildchar    -- wildchar for mapping (see :h wildcharm)

o.textwidth = 0             -- do not automatically break lines


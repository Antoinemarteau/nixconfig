local M = {}

local function map(mode, key, action)
    vim.keymap.set(mode, key, action, { silent = true })
end

local function unmap(mode, key)
    vim.keymap.del(mode, key, { silent = true })
end

-- Public functions to quickly declare keymaps

function M.nmap(key, action)
    map('n', key, action)
end

function M.vmap(key, action)
    map('v', key, action)
end

function M.omap(key, action)
    map('o', key, action)
end

function M.xmap(key, action)
    map('x', key, action)
end

function M.imap(key, action)
    map('i', key, action)
end

function M.smap(key, action)
    map('s', key, action)
end

function M.tmap(key, action)
    map('t', key, action)
end

function M.cmap(key, action)
    vim.keymap.set('c', key, action, {})
end

function M.map(key, action)
    map({'n', 'v', 'o'}, key, action)
end

function M.unmap(key)
    unmap({'n', 'v', 'o'}, key)
end

return M

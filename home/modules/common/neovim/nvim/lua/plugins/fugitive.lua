local nmap = require 'utils'.nmap

nmap('<leader>,s', ':vert Git<CR>')
nmap('<leader>,b', ':GBranches<CR>')
nmap('<leader>,t', ':Git pull<CR>')
nmap('<leader>,p', ':Git push<CR>')
nmap('<leader>,c', ':diffget //2<CR>')
nmap('<leader>,r', ':diffget //3<CR>')

vim.g.nremap = {r = 'h'}
vim.g.xremap = {r = 'h'}
vim.g.oremap = {r = 'h'}
vim.g.nremap = {c = 'l'}
vim.g.xremap = {c = 'l'}
vim.g.oremap = {c = 'l'}
vim.g.nremap = {s = 'k'}
vim.g.xremap = {s = 'k'}
vim.g.oremap = {s = 'k'}

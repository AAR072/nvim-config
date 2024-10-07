require("config.lazy")
require("config.remap")
vim.opt.relativenumber = true
-- Enable filetype detection, plugin and indent support
vim.cmd('filetype plugin indent on')

-- Set expandtab to use spaces instead of tabs
vim.opt.expandtab = true

-- Show existing tab with 2 spaces width
vim.opt.tabstop = 2

-- Set softtabstop to 2 spaces
vim.opt.softtabstop = 2

-- When indenting with '>', use 2 spaces width
vim.opt.shiftwidth = 2


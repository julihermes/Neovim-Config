vim.g.mapleader = " " -- Set leader key
vim.g.maplocalleader = " " -- Set local leader key
vim.g.have_nerd_font = true -- Set to use Nerd Font
vim.g.loaded_netrw = 1 -- disable netrw
vim.g.loaded_netrwPlugin = 1 -- disable netrw

vim.opt.breakindent = true -- Enable break indent
vim.opt.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.hlsearch = true -- Set highlight on search
vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.list = true -- Show Whitespace trail
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true -- Set relative line numbers
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.smartcase = true -- UNLESS \C or one or more capital letters in the search term
vim.opt.termguicolors = true -- NOTE: You should make sure your terminal supports this
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.opt.undofile = true -- Save undo history
vim.opt.updatetime = 250 -- Decrease update time

-- TAB configuration
vim.cmd("set expandtab") -- Convert tabs to spaces
vim.cmd("set tabstop=4") -- Determines the width of a tab character in columns
vim.cmd("set softtabstop=4") -- Affects the behavior of the tab and backspace keys
vim.cmd("set shiftwidth=4") -- The number of spaces inserted for each indentation

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

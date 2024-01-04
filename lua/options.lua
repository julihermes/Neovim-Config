vim.g.mapleader = ' '                   -- Set leader key
vim.g.maplocalleader = ' '              -- Set local leader key
vim.o.list = true                       -- Show Whitespace trail
vim.o.mouse = 'a'                       -- Enable mouse mode
vim.o.breakindent = true                -- Enable break indent vim.o.ignorecase = true                 -- Case-insensitive searching
vim.o.smartcase = true                  -- UNLESS \C or capital in search
vim.o.updatetime = 250                  -- Decrease update time
vim.o.timeoutlen = 300                  -- Decrease update time
vim.o.completeopt = 'menuone,noselect'  -- Set completeopt to have a better completion experience
vim.o.termguicolors = true              -- NOTE: You should make sure your terminal supports this
vim.wo.signcolumn = 'yes'               -- Keep signcolumn on by default
vim.wo.number = true                    -- Make line numbers default

-- TAB configuration
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

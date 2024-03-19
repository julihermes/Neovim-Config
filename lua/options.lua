vim.g.mapleader = ' '                   -- Set leader key
vim.g.maplocalleader = ' '              -- Set local leader key
vim.o.list = true                       -- Show Whitespace trail
vim.o.mouse = 'a'                       -- Enable mouse mode
vim.o.breakindent = true                -- Enable break indent
vim.opt.ignorecase = true               -- Case-insensitive searching
vim.o.smartcase = true                  -- UNLESS \C or one or more capital letters in the search term
vim.o.updatetime = 250                  -- Decrease update time
vim.o.timeoutlen = 300                  -- Decrease mapped sequence wait time
vim.o.completeopt = 'menuone,noselect'  -- Set completeopt to have a better completion experience
vim.o.termguicolors = true              -- NOTE: You should make sure your terminal supports this
vim.wo.signcolumn = 'yes'               -- Keep signcolumn on by default
vim.wo.number = true                    -- Make line numbers default
vim.wo.relativenumber = true            -- Set relative line numbers
vim.opt.showmode = false                -- Don't show the mode, since it's already in the status line
vim.opt.undofile = true                 -- Save undo history
vim.opt.inccommand = 'split'            -- Preview substitutions live, as you type!
vim.opt.cursorline = true               -- Show which line your cursor is on
vim.opt.hlsearch = true                 -- Set highlight on search
vim.g.have_nerd_font = true             -- Set to use Nerd Font

-- TAB configuration
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set({"n", "v"}, "<leader>yy", [["+yy]])
vim.keymap.set({"n", "v"}, "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]])
vim.keymap.set({"n", "v"}, "<leader>P", [["+P]])

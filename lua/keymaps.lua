vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlight pressing <Esc> in normal mode' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move."<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move."<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move."<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move."<CR>')

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- System clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = 'Copy to system clipboard' })
vim.keymap.set({"n", "v"}, "<leader>yy", [["+yy]], { desc = 'Copy line to system clipboard' })
vim.keymap.set({"n", "v"}, "<leader>Y", [["+Y]], { desc = 'Copy to cursor from endline to system clipboard' })
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]], { desc = 'Paste from system clipboard' })
vim.keymap.set({"n", "v"}, "<leader>P", [["+P]], { desc = 'Paste before cursor from system clipboard' })

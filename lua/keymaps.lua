vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlight pressing <Esc> in normal mode" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move."<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move."<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move."<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move."<CR>')

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- System clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>yy", [["+yy]], { desc = "Copy line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Copy to cursor from endline to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]], { desc = "Paste before cursor from system clipboard" })

-- Neo Tree keymaps
vim.keymap.set("n", "\\", ":Neotree focus<CR>", { desc = "Focus to file tree" })
vim.keymap.set("n", "|", ":Neotree close<CR>", { desc = "Focus to file tree" })

-- Telescope keymaps
local telescope = require("telescope.builtin")

local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return false
  end
  return git_root
end

-- Custom find_files function to search in git root if is a git repo
local function find_files_git_root()
  local git_root = find_git_root()
  if git_root then
    telescope.git_files()
  else
    telescope.find_files()
  end
end

-- Custom live_grep function to search in git root if is a git repo
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    telescope.live_grep({
      search_dirs = { git_root },
    })
  else
    telescope.live_grep()
  end
end

-- Custom grep_string function to search in git root if is a git repo
local function grep_string_git_root()
  local git_root = find_git_root()
  if git_root then
    telescope.grep_string({
      search_dirs = { git_root },
    })
  else
    telescope.grep_string()
  end
end

vim.api.nvim_create_user_command("FindFilesGitRoot", find_files_git_root, {})
vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})
vim.api.nvim_create_user_command("GrepStringGitRoot", grep_string_git_root, {})

vim.keymap.set("n", "<leader>sh", telescope.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", telescope.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<C-p>", ":FindFilesGitRoot<CR>", { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sf", telescope.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", telescope.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", ":GrepStringGitRoot<CR>", { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", ":LiveGrepGitRoot<CR>", { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", telescope.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", telescope.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", telescope.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", telescope.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Open [U]ndotree" })

-- LSP Keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("keymaps-config-lsp-attach", { clear = true }),
  callback = function(event)
    local conform = require("conform")
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", telescope.lsp_definitions, "[G]oto [D]efinition")
    map("gr", telescope.lsp_references, "[G]oto [R]eferences")
    map("gI", telescope.lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>D", telescope.lsp_type_definitions, "Type [D]efinition")
    map("<leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")
    map("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("<leader>f", conform.format, "[F]ormat buffer")
  end,
})

-- Linting
local lint = require("lint")
vim.keymap.set("n", "<leader>l", function()
  lint.try_lint()
end, { desc = "LSP: Trigger [L]inting for current file" })

-- Autocompletion
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- Select the [n]ext item
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Select the [p]revious item
    ["<C-p>"] = cmp.mapping.select_prev_item(),

    -- Scroll the documentation window [b]ack / [f]orward
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),

    -- Accept ([y]es) the completion.
    --  This will auto-import if your LSP supports it.
    --  This will expand snippets if the LSP sent a snippet.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),

    -- Manually trigger a completion from nvim-cmp.
    --  Generally you don't need this, because nvim-cmp will display
    --  completions whenever it has completion options available.
    ["<C-Space>"] = cmp.mapping.complete({}),

    -- Think of <c-l> as moving to the right of your snippet expansion.
    --  So if you have a snippet that's like:
    --  function $name($args)
    --    $body
    --  end
    --
    -- <c-l> will move you to the right of each of the expansion locations.
    -- <c-h> is similar, except moving you backwards.
    ["<C-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),

    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  }),
})

-- Treesitter keymaps
---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]o"] = "@loop.*",
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
      goto_next = {
        ["]d"] = "@conditional.outer",
      },
      goto_previous = {
        ["[d"] = "@conditional.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
})

-- Substitute
vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })

-- Lazygit
-- <leader>lg to open Lazygit (setting in plugin config)

--[[ General ]]
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move."<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move."<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move."<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move."<CR>')
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlight pressing <Esc> in normal mode" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>yy", [["+yy]], { desc = "Copy line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Copy to cursor from endline to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]], { desc = "Paste before cursor from system clipboard" })
vim.keymap.set("n", "<leader>aa", "ggVG", { desc = "Select all lines" })

--[[ Move ]]
local opts = { desc = "", noremap = true, silent = true }
opts.desc = "Move line down"
vim.keymap.set("n", "<A-j>", ":MoveLine(1)<CR>", opts)
opts.desc = "Move line up"
vim.keymap.set("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
opts.desc = "Move the character to the left"
vim.keymap.set("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
opts.desc = "Move the character to the rigth"
vim.keymap.set("n", "<A-l>", ":MoveHChar(1)<CR>", opts)
opts.desc = "Move the word forwards"
vim.keymap.set("n", "<leader>wf", ":MoveWord(1)<CR>", opts)
opts.desc = "Move the word backwards"
vim.keymap.set("n", "<leader>wb", ":MoveWord(-1)<CR>", opts)
opts.desc = "Move block down"
vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
opts.desc = "Move block up"
vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
opts.desc = "Move block left"
vim.keymap.set("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
opts.desc = "Move block rigth"
vim.keymap.set("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)

--[[ Neo Tree ]]
vim.keymap.set("n", "\\", ":SFMFocus<CR>", { desc = "Focus to file tree" })
vim.keymap.set("n", "|", ":SFMToggle<CR>", { desc = "Focus to file tree" })

--[[ Substitute ]]
local sub = require("substitute")
vim.keymap.set("n", "s", sub.operator, { desc = "Substitute operator, use with a motion", noremap = true })
vim.keymap.set("n", "ss", sub.line, { desc = "Substitute a line", noremap = true })
vim.keymap.set("n", "S", sub.eol, { desc = "Substitute from the cursor to end of line", noremap = true })
vim.keymap.set("x", "s", sub.visual, { desc = "Substitute operator in visual mode", noremap = true })
local subr = require("substitute.range")
vim.keymap.set("n", "<leader>s", subr.operator, { desc = "Range operator, use with two motion", noremap = true })
vim.keymap.set("x", "<leader>s", subr.visual, { desc = "Range operator in visual mode", noremap = true })
vim.keymap.set("n", "<leader>ss", subr.word, { desc = "Range operator for current word", noremap = true })

--[[ Harpoon ]]
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "[A]dd to [H]arpoon" })
vim.keymap.set("n", "<leader>h", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open [H]arpoon list" })
vim.keymap.set("n", "<leader>1", function()
  harpoon:list():select(1)
end, { desc = "Open [1]first harpoon buffer" })
vim.keymap.set("n", "<leader>2", function()
  harpoon:list():select(2)
end, { desc = "Open [2]second harpoon buffer" })
vim.keymap.set("n", "<leader>3", function()
  harpoon:list():select(3)
end, { desc = "Open [3]third harpoon buffer" })
vim.keymap.set("n", "<leader>4", function()
  harpoon:list():select(4)
end, { desc = "Open [4]fourth harpoon buffer" })
vim.keymap.set("n", "<A-p>", function()
  harpoon:list():prev({ ui_nav_wrap = true })
end, { desc = "Open [P]revious harpoon buffer" })
vim.keymap.set("n", "<A-n>", function()
  harpoon:list():next({ ui_nav_wrap = true })
end, { desc = "Open [N]ext harpoon buffer" })

--[[ Telescope ]]
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
    telescope.git_files({ show_untracked = true })
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

vim.keymap.set("n", "<C-p>", ":FindFilesGitRoot<CR>", { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fk", telescope.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fw", ":GrepStringGitRoot<CR>", { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>fg", ":LiveGrepGitRoot<CR>", { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fd", telescope.diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fr", telescope.resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>f.", telescope.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", telescope.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Open [U]ndotree" })
vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>ft", telescope.builtin, { desc = "[F]ind [S]elect Telescope" })

--[[ LSP ]]
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

--[[ Treesitter ]]
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

--[[ Trouble ]]
vim.keymap.set("n", "<leader>q", function()
  require("trouble").toggle()
end)

-- Lazygit
-- <leader>lg to open Lazygit (setting in plugin config)

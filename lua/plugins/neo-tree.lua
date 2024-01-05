return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            "node_modules",
            ".git"
          },
        }
      }
    })
    vim.keymap.set("n", "\\", ":Neotree filesystem reveal left<CR>", {})
  end,
}

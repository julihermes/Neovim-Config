return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          "node_modules",
          ".git",
        },
      },
      follow_current_file = {
        enabled = true,
      },
    },
    event_handlers = {
      {
        event = "neo_tree_popup_input_ready",
        handler = function()
          -- enter input popup with normal mode by default.
          vim.cmd("stopinsert")
        end,
      },
    },
  },
}

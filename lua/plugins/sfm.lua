return {
  "dinhhuy258/sfm.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "dinhhuy258/sfm-filter.nvim",
    "julihermes/sfm-focus.nvim",
  },
  config = function()
    local sfm = require("sfm").setup({
      mappings = {
        list = {
          {
            key = "<SPACE>",
            action = "",
          },
          {
            key = "<C-SPACE>",
            action = "toggle_selection",
          },
          {
            key = "<M-SPACE>",
            action = "clear_selections",
          },
        },
      },
    })

    sfm:load_extension("sfm-filter", {
      show_hidden = true,
      ignore_names = {
        ".git",
        "node_modules",
      },
    })
    sfm:load_extension("sfm-focus", {})
  end,
}

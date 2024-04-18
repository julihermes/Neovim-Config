return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      hide_inactive_statusline = true,
      lualine_bold = true,
    })
    vim.cmd.colorscheme("tokyonight")
  end,
}

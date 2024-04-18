return {
  { "tpope/vim-sleuth" },
  { "numToStr/Comment.nvim", opts = {}, lazy = false },
  { "nvim-lualine/lualine.nvim", opts = { options = { theme = "tokyonight", ignore_focus = { "sfm" } } } },
  { "fedepujol/move.nvim", opts = {} },
  { "gbprod/substitute.nvim", opts = {} },
  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} },
}

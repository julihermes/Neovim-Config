return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup({
      settings = {
        sync_on_ui_close = true,
      },
    })
  end,
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "vimdoc", "vim", "bash", "lua", "javascript", "typescript" },
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
}

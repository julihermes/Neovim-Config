return {
	"echasnovski/mini.nvim",
	config = function()
		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Move any selection in any direction
		-- use Alt + <hjkl> to move.
		require("mini.move").setup()
	end,
}

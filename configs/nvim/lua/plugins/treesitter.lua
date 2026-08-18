return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter").install("all"):wait(300000)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "*" },
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}

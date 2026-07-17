return {
	"nvim-treesitter",
	-- branch = "main",
	-- lazy = false,
	-- build = ":TSUpdate",
	after = function()
		require("nvim-treesitter")
			.install({
				"c",
				"cpp",
				"rust",
				"python",
				"javascript",
				"typescript",
				"lua",
				"go",
				"typst",
				"markdown",
				"markdown_inline",
			})
			:wait(300000)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "*" },
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}

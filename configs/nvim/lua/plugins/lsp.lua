return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.lsp.enable({
			"astro",
			"clangd",
			"cssls",
			"html",
			"jsonls",
			"lua_ls",
			"nixd",
			"pyright",
			"rust_analyzer",
			"texlab",
			"tinymist",
			"tsgo",
		})
	end,
}

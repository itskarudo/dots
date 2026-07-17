return {
	"nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		vim.lsp.enable({
			"astro",
			"clangd",
			"cssls",
			"html",
			"jsonls",
			"lua_ls",
			"rust_analyzer",
			"tinymist",
			"ts_ls",
			"ty",
      "nixd",
		})
	end,
}

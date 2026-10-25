return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
		for entry, entry_type in vim.fs.dir(lsp_dir) do
			local server = entry:match("^(.*)%.lua$")
			if server and entry_type == "file" then
				vim.lsp.config(server, dofile(lsp_dir .. "/" .. entry))
			end
		end

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
			"tsc",
		})
	end,
}

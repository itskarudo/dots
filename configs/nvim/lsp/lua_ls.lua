---@type vim.lsp.Config
return {
	---@type lspconfig.settings.lua_ls
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
				},
			},
		},
	},
}

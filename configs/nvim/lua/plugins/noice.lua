return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("notify").setup({
			render = "compact",
			stages = "static",
		})

		require("noice").setup({
			routes = {
				{
					filter = {
						event = "lsp",
						kind = "progress",
						any = {
							{ find = "pyright" },
						},
					},
					opts = { skip = true },
				},
			},
			presets = {
				long_message_to_split = true,
				lsp_doc_border = true,
			},
		})
	end,
}

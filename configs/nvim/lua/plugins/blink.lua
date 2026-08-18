return {
	"saghen/blink.cmp",
	dependencies = {
		"saghen/blink.lib",
		"rafamadriz/friendly-snippets",
	},
	build = function()
		require("blink.cmp").build():pwait()
	end,

	opts = {
		keymap = {
			preset = "enter",

			["<Tab>"] = {
				"select_next",
				"snippet_forward",
				"fallback",
			},

			["<S-Tab>"] = {
				"select_prev",
				"snippet_backward",
				"fallback",
			},
		},

		appearance = {
			nerd_font_variant = "normal",
		},
		completion = { documentation = { auto_show = true } },

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = {
			sorts = { "exact", "score", "sort_text" },
			implementation = "prefer_rust_with_warning",
		},
	},
}

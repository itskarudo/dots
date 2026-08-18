return {
	"conform.nvim",
	event = { "BufReadPre", "BufNewFile", "InsertLeave" },
	config = {
		formatters_by_ft = {
			astro = { "prettierd" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			css = { "biome" },
			html = { "biome" },
			javascript = { "biome" },
			javascriptreact = { "biome" },
			lua = { "stylua" },
			nix = { "nixfmt" },
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			rust = { "rustfmt" },
			typescript = { "biome" },
			typescriptreact = { "biome" },
		},

		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = "fallback",
		},
	},
}

return {
	"conform.nvim",
	event = { "BufReadPre", "BufNewFile", "InsertLeave" },
	after = function()
    require("conform").setup({
      formatters_by_ft = {
        astro = { "prettierd" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        css = { "biome" },
        go = { "gofumpt", "goimports-reviser", "golines" },
        html = { "biome" },
        lua = { "stylua" },
        nix = { "nixfmt" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        rust = { "rustfmt" },
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = "fallback",
      },
    })
  end
}

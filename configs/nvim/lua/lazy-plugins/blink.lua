return {
	"blink.cmp",
	event = "InsertEnter",
	-- dependencies = { "rafamadriz/friendly-snippets" },

	after = function()
    require("blink.cmp").setup({
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

      fuzzy = { implementation = "prefer_rust_with_warning" },
    })
  end
}

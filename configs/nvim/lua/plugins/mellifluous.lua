return {
	"ramojus/mellifluous.nvim",
	lazy = false,
	config = function()
		require("mellifluous").setup({
			flat_background = {
				line_numbers = true,
				cursor_line_number = true,
			},
			highlight_overrides = {
				dark = function(hl, colors)
					hl.set("StatusLine", { bg = colors.bg, fg = hl.get("StatusLine").fg })
				end,
			},
		})
		vim.cmd("colorscheme mellifluous")
	end,
}

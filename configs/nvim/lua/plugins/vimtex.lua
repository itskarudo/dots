return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.tex_conceal = "abdmg"
		vim.g.vimtex_syntax_enabled = false
		vim.g.vimtex_complete_enabled = false -- we use texlab
		vim.g.vimtex_quickfix_open_on_warning = 0
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_view_zathura_use_synctex = 0
	end,
}

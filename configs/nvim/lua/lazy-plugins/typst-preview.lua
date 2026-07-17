return {
	"typst-preview.nvim",
	ft = "typst",
	version = "1.*",
  after = function()
    require("typst-preview.nvim").setup({})
  end
}

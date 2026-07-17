return {
  "indent-blankline.nvim",
	after = function()
    require("ibl").setup({
      indent = { char = "│" },
      scope = { show_start = false, show_end = false },
    })
  end
}

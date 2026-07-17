vim.keymap.set("n", "<leader>p", ":TypstPreview<CR>", { silent = true, buffer = 0 })

vim.keymap.set({ "x", "o" }, "am", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@math.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "im", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@math.inner", "textobjects")
end)

vim.cmd([[
	"setlocal wrapmargin=10
	"setlocal formatoptions+=t
	"setlocal linebreak
	setlocal spell
	"setlocal wrap
]])

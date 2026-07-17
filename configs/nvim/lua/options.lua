vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.ruler = false
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.linebreak = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.opt.ignorecase = true

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.g.mapleader = " "

vim.cmd("set completeopt+=menuone,noselect,popup")

vim.diagnostic.config({
	virtual_lines = { current_line = true },
	virtual_text = false,
	underline = true,
	signs = true,
	update_in_insert = true,
})

vim.lsp.document_color.enable(true, {}, {
	style = "virtual",
})

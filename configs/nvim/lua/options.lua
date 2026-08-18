vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.linebreak = true
vim.opt.cmdheight = 0
vim.opt.report = 999999999

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 2
vim.opt.updatetime = 50
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.cmd("set completeopt+=menuone,noselect,popup")

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})

vim.lsp.document_color.enable(true, {}, {
	style = "virtual",
})

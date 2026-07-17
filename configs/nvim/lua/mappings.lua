local map = vim.keymap.set

map("i", "jk", "<Esc>")

map("n", "<leader><leader>", ":nohl<CR>", { silent = true })
map("n", "<C-n>", ":Neotree left toggle<CR>", { silent = true })

local telescope = require("telescope.builtin")

map("n", "<leader>f", telescope.find_files)
map("n", "<leader>w", telescope.live_grep)
map("n", "<leader>h", telescope.help_tags)

local diag = require("diagnostics")
map("n", "<leader>dk", function()
	diag.cycle(-1)
end)
map("n", "<leader>dj", function()
	diag.cycle(1)
end)

map("n", "<S-k>", function()
	vim.lsp.buf.hover({ border = "single" })
end)

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map({ "n" }, "gD", vim.lsp.buf.declaration)
map({ "n" }, "gd", vim.lsp.buf.definition)

map("n", "<Tab>", ":BufferNext<CR>", { silent = true })
map("n", "<S-Tab>", ":BufferPrevious<CR>", { silent = true })
map("n", "<leader>x", ":BufferClose<CR>", { silent = true })
map("n", "<leader>b", ":enew<CR>", { silent = true })

map("n", "<leader>ca", vim.lsp.buf.code_action)

map("n", ";", ":", { noremap = true })

map("n", "gp", ":Gitsigns preview_hunk_inline<CR>", { silent = true })

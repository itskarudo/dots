vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<cr>", { silent = true })
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<cr>", { silent = true })
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<cr>", { silent = true })
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<cr>", { silent = true })

vim.keymap.set("n", "<leader>n", ":Oil<CR>", { silent = true })
vim.keymap.set("i", "jk", "<Esc>", { silent = true })
vim.keymap.set("n", "<leader><leader>", ":nohl<CR>", { silent = true })

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", telescope.find_files, { silent = true })
vim.keymap.set("n", "<leader>d", telescope.buffers, { silent = true })
vim.keymap.set("n", "<leader>w", telescope.live_grep, { silent = true })
vim.keymap.set("n", "<leader>h", telescope.help_tags, { silent = true })

vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", "<leader>b", ":enew<CR>", { silent = true })
vim.keymap.set("n", "<leader>x", function()
	if vim.bo.modified then
		local choice = vim.fn.confirm("Buffer has unsaved changes. Close anyway?", "&Yes\n&No", 2)
		if choice == 1 then
			vim.cmd("bdelete!")
		end
	else
		vim.cmd("bdelete")
	end
end, { desc = "Delete buffer (confirm if modified)" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true })
vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, { silent = true })

vim.keymap.set("n", "<leader>s", vim.diagnostic.open_float, { silent = true })

vim.keymap.set("n", "gp", ":Gitsigns preview_hunk_inline<CR>", { silent = true })

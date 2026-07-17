return {
	"barbar.nvim",
	-- dependencies = {
	-- 	"nvim-tree/nvim-web-devicons",
	-- },
	after = function()
		require("barbar").setup({
			animation = false,
			icons = {
				button = "󰅖",
				modified = { button = "" },
			},
			no_name_title = "No Name",
		})

		local api = require("barbar.api")

		local widths = {
			left = {}, --- @type {[string]: nil|integer}
			right = {}, --- @type {[string]: nil|integer}
		}

		local function total_widths(side)
			local offset = 0
			local win_separator_width = side == "left" and 1 or 2 -- It looks better like this… don't ask me why
			for _, width in pairs(widths[side]) do
				offset = offset + width + win_separator_width
			end

			-- remove this cuz i want the tabs after the separator
			-- offset = offset - 1

			return offset
		end

		local function setup_sidebar_offset(ft)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(tbl)
					local bufwinid --- @type nil|integer
					local side
					local autocmd = vim.api.nvim_create_autocmd({ "BufWinEnter", "WinScrolled" }, {
						callback = function()
							if bufwinid == nil then
								bufwinid = vim.fn.bufwinid(tbl.buf)
							end
							if not vim.api.nvim_win_is_valid(bufwinid) then
								return
							end
							local col = vim.api.nvim_win_get_position(bufwinid)[2]
							local other_side
							local middle = vim.o.columns / 2
							if col < middle then
								side, other_side = "left", "right"
							else
								side, other_side = "right", "left"
							end

							local width = vim.api.nvim_win_get_width(bufwinid)
							if width ~= widths[ft] then
								widths[side][ft] = width
								widths[other_side][ft] = nil
								api.set_offset(total_widths(side), nil, nil, side)
							end
						end,
					})

					vim.api.nvim_create_autocmd("BufWinLeave", {
						buffer = tbl.buf,
						callback = function()
							if widths[side] then
								widths[side][ft] = nil
								api.set_offset(total_widths(side), nil, nil, side, {})
							end
							pcall(vim.api.nvim_del_autocmd, autocmd)
						end,
						once = true,
					})
				end,
				pattern = ft,
			})
		end

		setup_sidebar_offset("neo-tree")
	end
}

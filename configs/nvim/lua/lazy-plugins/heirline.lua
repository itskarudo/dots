-- ai slop
return {
	"heirline.nvim",
	-- dependencies = {
	-- 	"nvim-tree/nvim-web-devicons",
	-- },
	after = function()
		require("nvim-web-devicons").setup({
			default = true,
		})

		require("nvim-web-devicons").set_default_icon("󰈚", "#C4746E", 65)

		local conditions = require("heirline.conditions")

		local colors = {
			bg = "#181616",
			fg = "#cdd6f4",

			comp_bg = "#262424",

			mode_n = "#8BA4B0",
			mode_i = "#8992A7",
			mode_v = "#8EA4A2",
			mode_c = "#8A9B7B",
			mode_r = "#B6927B",
			mode_s = "#8BA4B0",
			mode_t = "#C4B28A",

			file = "#C4746E",
			git = "#5e5c5c",
			cwd = "#B6927B",
			pos = "#C4B28A",
		}

		require("heirline").setup({
			opts = {
				colors = colors,
			},

			statusline = (function()
				local Align = { provider = "%=" }

				local Space = { provider = " " }

				local function make_component(opts)
					local function resolve(value, self)
						if type(value) == "function" then
							return value(self)
						end
						return value
					end

					return {
						{
							provider = function(self)
								local icon = resolve(opts.icon, self)
								if not icon or icon == "" then
									return ""
								end
								return " " .. icon .. " "
							end,
							hl = function(self)
								return { fg = colors.comp_bg, bg = resolve(opts.acc, self) }
							end,
						},
						{
							provider = function(self)
								local text = resolve(opts.text, self)
								if not text or text == "" then
									return ""
								end
								return " " .. text .. " "
							end,
							hl = function(self)
								return { fg = resolve(opts.acc, self), bg = colors.comp_bg }
							end,
						},
					}
				end

				local ViMode = {
					init = function(self)
						self.mode = vim.fn.mode(1)
					end,
					static = {
						mode_names = {
							n = "NORMAL",
							no = "O-PENDING",
							nov = "O-PENDING",
							noV = "O-PENDING",
							["no\22"] = "O-PENDING",
							niI = "NORMAL",
							niR = "NORMAL",
							niV = "NORMAL",
							nt = "NORMAL",
							v = "VISUAL",
							vs = "VISUAL",
							V = "V-LINE",
							Vs = "V-LINE",
							["\22"] = "V-BLOCK",
							["\22s"] = "V-BLOCK",
							s = "SELECT",
							S = "S-LINE",
							["\19"] = "S-BLOCK",
							i = "INSERT",
							ic = "INSERT",
							ix = "INSERT",
							R = "REPLACE",
							Rc = "REPLACE",
							Rx = "REPLACE",
							Rv = "V-REPLACE",
							Rvc = "V-REPLACE",
							Rvx = "V-REPLACE",
							c = "COMMAND",
							cv = "EX",
							r = "PROMPT",
							rm = "MORE",
							["r?"] = "CONFIRM",
							["!"] = "SHELL",
							t = "TERMINAL",
						},
						mode_colors = {
							n = colors.mode_n,
							i = colors.mode_i,
							v = colors.mode_v,
							V = colors.mode_v,
							["\22"] = colors.mode_v,
							c = colors.mode_c,
							s = colors.mode_s,
							S = colors.mode_s,
							["\19"] = colors.mode_s,
							R = colors.mode_r,
							r = colors.mode_r,
							["!"] = colors.mode_n,
							t = colors.mode_t,
						},
					},
					update = {
						"ModeChanged",
						pattern = "*:*",
						callback = vim.schedule_wrap(function()
							vim.cmd("redrawstatus")
						end),
					},
				}

				local ModeComponent = vim.tbl_deep_extend(
					"force",
					ViMode,
					make_component({
						icon = "",
						acc = function(self)
							return self.mode_colors[self.mode:sub(1, 1)] or colors.mode_n
						end,
						text = function(self)
							return self.mode_names[self.mode] or self.mode:upper()
						end,
					})
				)

				local FileBlock = {
					init = function(self)
						self.filename = vim.api.nvim_buf_get_name(0)
						local ext = vim.fn.fnamemodify(self.filename, ":e")
						self.file_icon = "󰈚"

						local ok, devicons = pcall(require, "nvim-web-devicons")
						if ok then
							local icon = devicons.get_icon(self.filename, ext, { default = true })
							self.file_icon = icon or self.file_icon
						end
					end,
				}

				local FileNameComponent = vim.tbl_deep_extend(
					"force",
					FileBlock,
					make_component({
						icon = function(self)
							return self.file_icon
						end,
						acc = function()
							return colors.file
						end,
						text = function(self)
							if self.filename == "" then
								return "Empty"
							end
							return vim.fn.fnamemodify(self.filename, ":t")
						end,
					})
				)

				-- make dynamic icon work in factory
				FileNameComponent[1].provider = function(self)
					return " " .. (self.file_icon or "󰈚") .. " "
				end

				local GitBranchComponent = {
					condition = conditions.is_git_repo,
					{
						provider = function(_)
							return "  " .. vim.b.gitsigns_head
						end,
						hl = function(_)
							return { fg = colors.git, bg = nil }
						end,
					},
				}

				local WorkDirComponent = make_component({
					icon = "",
					acc = function()
						return colors.cwd
					end,
					text = function()
						local cwd = vim.fn.getcwd(0)
						cwd = vim.fn.fnamemodify(cwd, ":~")
						return vim.fn.fnamemodify(cwd, ":t")
					end,
				})

				local PositionComponent = make_component({
					icon = "",
					acc = function()
						return colors.pos
					end,
					text = function()
						local line = vim.fn.line(".")
						local col = vim.fn.col(".")
						local total = vim.fn.line("$")
						local percent = math.floor((line / math.max(total, 1)) * 100)
						return string.format("%d:%d %d%%%%", line, col, percent)
					end,
				})

				return {
					hl = { bg = colors.bg, fg = colors.fg },

					ModeComponent,
					Space,
					FileNameComponent,
					Space,
					GitBranchComponent,

					Align,

					WorkDirComponent,
					Space,
					PositionComponent,
				}
			end)(),
		})
	end,
}

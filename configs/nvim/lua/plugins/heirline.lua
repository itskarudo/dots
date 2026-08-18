return {
	"rebelot/heirline.nvim",
	config = function()
		local heirline = require("heirline")
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		local colors = require("mellifluous.colors").get_colors()

		local function setup_colors()
			return {
				bg = colors.bg.hex,
				bright_bg = colors.bg2.hex,
				fg = "#686868",
				red = utils.get_highlight("DiagnosticError").fg,
				string = utils.get_highlight("String").fg,
				orange = utils.get_highlight("Keyword").fg,
				purple = utils.get_highlight("Constant").fg,
				blue = utils.get_highlight("Function").fg,

				diag_warn = utils.get_highlight("DiagnosticWarn").fg,
				diag_error = utils.get_highlight("DiagnosticError").fg,
				diag_hint = utils.get_highlight("DiagnosticHint").fg,
				diag_info = utils.get_highlight("DiagnosticInfo").fg,
			}
		end

		heirline.load_colors(setup_colors())

		local align = { provider = "%=" }
		local space = { provider = " " }

		local mode = {
			init = function(self)
				self.mode = vim.fn.mode(1)
				if not self.once then
					vim.api.nvim_create_autocmd("ModeChanged", { command = "redrawstatus" })
					self.once = true
				end
			end,
			static = {
				mode_names = {
					n = "NORMAL",
					no = "NORMAL",
					nov = "NORMAL",
					noV = "NORMAL",
					["no\22"] = "NORMAL",
					niI = "NORMAL",
					niR = "NORMAL",
					niV = "NORMAL",
					nt = "NORMAL",
					v = "VISUAL",
					vs = "VISUAL",
					V = "VISUAL",
					Vs = "VISUAL",
					["\22"] = "VISUAL",
					["\22s"] = "VISUAL",
					s = "SELECT",
					S = "SELECT",
					["\19"] = "SELECT",
					i = "INSERT",
					ic = "INSERT",
					ix = "INSERT",
					R = "REPLACE",
					Rc = "REPLACE",
					Rx = "REPLACE",
					Rv = "REPLACE",
					Rvc = "REPLACE",
					Rvx = "REPLACE",
					c = "COMMAND",
					cv = "Ex",
					r = "...",
					rm = "M",
					["r?"] = "?",
					["!"] = "!",
					t = "TERM",
				},
				mode_colors = {
					n = "grey",
					i = "blue",
					v = "orange",
					V = "orange",
					["\22"] = "orange",
					c = "string",
					s = "purple",
					S = "purple",
					["\19"] = "purple",
					R = "blue",
					r = "blue",
					["!"] = "red",
					t = "red",
				},
			},
			provider = function(self)
				return " %2(" .. self.mode_names[self.mode] .. "%) "
			end,
			hl = function(self)
				return { bg = self.mode_colors[self.mode], fg = "bg", bold = true }
			end,
			update = "ModeChanged",
		}

		local file = (function()
			local name_block = {
				init = function(self)
					self.filename = vim.api.nvim_buf_get_name(0)
				end,
				hl = { bg = "bright_bg", fg = "fg", bold = true },
			}

			local icon = {
				init = function(self)
					local filename = self.filename
					local extension = vim.fn.fnamemodify(filename, ":e")
					self.icon = require("nvim-web-devicons").get_icon(filename, extension, { default = true })
				end,
				provider = function(self)
					return self.icon and (" " .. self.icon .. " ")
				end,
			}

			local name = {
				init = function(self)
					self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
					if self.lfilename == "" then
						self.lfilename = "[Untitled]"
					end
				end,

				{
					flexible = 6,
					{
						provider = function(self)
							return self.lfilename .. " "
						end,
					},
					{
						provider = function(self)
							return vim.fn.pathshorten(self.lfilename) .. " "
						end,
					},
				},
			}

			local flags = {
				{
					provider = function()
						if vim.bo.modified then
							return "[+] "
						end
					end,
				},
				{
					provider = function()
						if (not vim.bo.modifiable) or vim.bo.readonly then
							return "[-] "
						end
					end,
					hl = { fg = "red" },
				},
			}

			name_block = utils.insert(name_block, icon, name, unpack(flags), { provider = "%<" })

			local type = {
				provider = function()
					return string.upper(vim.bo.filetype)
				end,
				hl = { fg = utils.get_highlight("Type").fg, bold = true },
			}

			local ruler = {
				provider = " %l:%c ",
				hl = { bg = "bright_bg", fg = "fg", bold = true },
			}

			return {
				name_block = name_block,
				type = type,
				ruler = ruler,
			}
		end)()

		local git = {
			condition = conditions.is_git_repo,

			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,

			hl = { bg = "bright_bg", fg = "fg", bold = true },

			{
				provider = function(self)
					if self.status_dict.head ~= "" then
						return "  " .. self.status_dict.head .. " "
					end
					return "  "
				end,
			},
			-- 	{
			-- 		condition = function(self)
			-- 			return self.has_changes
			-- 		end,
			-- 		provider = "(",
			-- 		hl = { fg = "grey" },
			-- 	},
			-- 	{
			-- 		provider = function(self)
			-- 			local count = self.status_dict.added or 0
			-- 			return count > 0 and ("+" .. count)
			-- 		end,
			-- 		hl = { fg = "grey" },
			-- 	},
			-- 	{
			-- 		provider = function(self)
			-- 			local count = self.status_dict.removed or 0
			-- 			return count > 0 and ("-" .. count)
			-- 		end,
			-- 		hl = { fg = "grey" },
			-- 	},
			-- 	{
			-- 		provider = function(self)
			-- 			local count = self.status_dict.changed or 0
			-- 			return count > 0 and ("~" .. count)
			-- 		end,
			-- 		hl = { fg = "grey" },
			-- 	},
			-- 	{
			-- 		condition = function(self)
			-- 			return self.has_changes
			-- 		end,
			-- 		provider = ")",
			-- 		hl = { fg = "grey" },
			-- 	},
			-- 	{
			-- 		provider = " ",
			-- 	},
		}

		local lsp = {

			condition = conditions.has_diagnostics,

			{
				init = function(self)
					self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
					self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
					self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
					self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
				end,
				hl = { bg = "bright_bg", bold = true },
				{
					provider = function(self)
						if self.errors > 0 then
							return "  " .. self.errors
						end
					end,
					hl = { fg = "diag_error" },
				},
				{
					provider = function(self)
						if self.warnings > 0 then
							return "  " .. self.warnings
						end
					end,
					hl = { fg = "diag_warn" },
				},
				{
					provider = function(self)
						if self.info > 0 then
							return "  " .. self.info
						end
					end,
					hl = { fg = "diag_info" },
				},
				{
					provider = function(self)
						if self.hints > 0 then
							return "  " .. self.hints
						end
					end,
					hl = { fg = "diag_hint" },
				},
				{
					provider = " ",
				},
			},
			space,
		}

		local macro = {
			condition = function()
				return vim.fn.reg_recording() ~= ""
			end,
			update = {
				"RecordingEnter",
				"RecordingLeave",
			},
			hl = { bg = "bright_bg", fg = "fg", bold = true },
			{
				provider = function()
					return " recording @" .. vim.fn.reg_recording() .. " "
				end,
			},
		}

		git = { flexible = 3, git, { provider = "" } }
		file.ruler = { flexible = 7, file.ruler, { provider = "" } }
		mode = { flexible = 8, mode, { provider = "" } }

		local default_statusline = {
			condition = function()
				return conditions.is_active()
			end,

			space,
			mode,
			space,
			file.name_block,
			space,
			git,
			align,
			macro,
			space,
			lsp,
			file.ruler,
			space,
		}

		local statuslines = {
			hl = "StatusLine",
			fallthrough = false,
			default_statusline,
		}

		heirline.setup({ statusline = statuslines })

		local group = vim.api.nvim_create_augroup("Heirline", { clear = true })
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				require("heirline").reset_highlights()
				require("heirline").load_colors(setup_colors())
			end,
			group = group,
		})
	end,
}

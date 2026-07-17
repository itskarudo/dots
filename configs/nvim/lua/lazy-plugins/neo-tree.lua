return {
	"neo-tree.nvim",
	-- dependencies = {
	-- 	"nvim-lua/plenary.nvim",
	-- 	"MunifTanjim/nui.nvim",
	-- 	"nvim-tree/nvim-web-devicons",
	-- },
	after = function()
		local common = require("neo-tree.sources.common.components")

		require("neo-tree").setup({
			filesystem = {
				components = {
					name = function(config, node, state)
						local name = common.name(config, node, state)
						if node:get_depth() == 1 then
							name.text = vim.fs.basename(state.path)
						end
						return name
					end,
					icon = function(config, node, state)
						local icon = common.icon(config, node, state)
						icon.text = icon.text .. " "
						return icon
					end,
				},
			},

			default_component_configs = {
				indent = {
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					indent_size = 2,
				},
			},

			window = {
				width = 45,
				options = {
					nowait = true,
				},
				mappings = {
					["o"] = { "open" },
					["oc"] = "noop",
					["od"] = "noop",
					["og"] = "noop",
					["om"] = "noop",
					["on"] = "noop",
					["os"] = "noop",
					["ot"] = "noop",
				},
			},
		})
	end,
}
